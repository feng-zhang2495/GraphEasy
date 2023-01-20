// Implementation of the shunting algorithm
float shuntingAlgorithm(ArrayList<String> equation) {
  boolean isNumber;
  ArrayList<String> outputQueue = new ArrayList<String>();
  ArrayList<String> evaluationStack = new ArrayList<String>();
  ArrayList<String> operatorStack = new ArrayList<String>();

  // Making a hashmap of operator priorities
  HashMap<String, Integer> priorities = new HashMap<String, Integer>();
  priorities.put("(", 0);
  priorities.put("[", 0);
  priorities.put("sin", 1);
  priorities.put("+", 1);
  priorities.put("-", 1);
  priorities.put("*", 2);
  priorities.put("/", 2);
  priorities.put("^", 3);
  priorities.put(")", 4);
  priorities.put("]", 4);


  // Goes through each character in the equation
  for (int i = 0; i < equation.size(); i++) {
    String character = equation.get(i);
    
    
    
    // If the character isnt just a blank space
    if (!character.equals(" ")) {

      // Try converting the character to an integer to check if it is an integer
      isNumber = isNumber(character);

      // IF THE CHARACTER IS A NUMBER
      if (isNumber) {
        int pos = i;

        // If the next character is still a number or a decimal character, continue to the next character
        while (isNumber(equation.get(pos)) || equation.get(pos).equals(".")) {
          pos++;

          if (pos == equation.size()) {
            break;
          }
        }

        // Add the whole number to the output queue
        String output = "";
        for (int m = i; m < pos; m++) {
          output += equation.get(m);
        }

        outputQueue.add(output);
        i = pos-1;
      }

      // IF THE CHARACTER IS PART OF A FUNCTION
      else if (character.equals("s") || character.equals("s") || character.equals("t")) {
        // Sine function
        if(character.equals("s") && equation.get(i+1).equals("i") && equation.get(i+2).equals("n")) {
          operatorStack.add(0, "sin");
          i += 2;
        }
      }

      // IF THE CHARACTER IS NOT A NUMBER BUT AN OPERATOR OR FUNCTION
      else {
        
        
        // The case where a negative symbol does not represent subtraction, but rather a negative number
        if (character == "-") {
        
          if (i == 0) {
            int pos = i+1;

            // If the next character is still a number or a decimal character, continue to the next character
            while (isNumber(equation.get(pos)) || equation.get(pos) == ".") {
              pos++;

              if (pos == equation.size()) {
                break;
              }
            }

            // Add the whole number to the output queue
            String output = "";
            for (int m = i; m < pos; m++) {
              output += equation.get(m);
            }

            outputQueue.add(output);
            i = pos-1;
          }
          
          // If the negative number is not at the beginning of the string
          if (i > 0) {
            if (isNumber(equation.get(i-1)) == false && character == "-") {
              int pos = i+1;

              // If the next character is still a number or a decimal character, continue to the next character
              while (isNumber(equation.get(pos)) || equation.get(pos) == ".") {
                pos++;

                if (pos == equation.size()) {
                  break;
                }
              }

              // Add the whole number to the output queue
              String output = "";
              for (int m = i; m < pos; m++) {
                output += equation.get(m);
              }

              outputQueue.add(output);
              i = pos-1;
            }
          }
        }


        // If the operator stack is empty, always add the operator
        else if (operatorStack.size() == 0 ) {
          operatorStack.add(0, character);
        }

        // If the character is a left parenthesis, always add it to the operator stack
        
        else if (priorities.get(character) == 0) {
          operatorStack.add(0, character);
        }

        // If the character is a right bracket, pop all the operators into the output queue up to the left bracket
        else if (priorities.get(character) == priorities.get(")")) {
          while (priorities.get(operatorStack.get(0)) != 0) {

            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);


            // Prevents a null pointer exception
            if (operatorStack.size() == 0) {
              break;
            }
          }
          operatorStack.remove(0);
        }

        // If the character operator has a higher priority than the one in stack, add it to the operator stack.
        else if (priorities.get(operatorStack.get(0)) < priorities.get(character)) {
          operatorStack.add(0, character);
        }

        // If the character has equal or lower priority than the one in stack, add it to the output queue
        else {
          println(priorities.get(character) <= priorities.get(operatorStack.get(0)));
          while (priorities.get(character) <= priorities.get(operatorStack.get(0))) {
            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);

            // Prevents a null pointer exception
            if(operatorStack.size() == 0) {
              break;
            }
          }
          operatorStack.add(0, character);
        }
      }
    }
  }
  
  
  // If there are still characters left in the operatorStack array
  if (operatorStack.size() != 0) {
    // Append them to the output array
    for (int i = 0; i < operatorStack.size()+1; i++) {
      outputQueue.add(operatorStack.get(0));
      operatorStack.remove(0);
    }
  }
  //println("FINAL OUTPUT ARRAY", outputQueue);
  //println("FINAL OPERATOR STACK", operatorStack);

  // Evaluating the postfix expression in the outputQueue Array
  for (int i = 0; i < outputQueue.size(); i++) {
    println("OUTPUT", outputQueue);
    println("EVAL", evaluationStack);
    String output = outputQueue.get(i);

    // If the output is a number or a function
    if (isNumber(output)) {
      evaluationStack.add(0, output);
    }

    // If its an operator
    else {
      
      if (evaluationStack.size() == 1) {
        float number = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        
        if (output.equals("sin")) {
          evaluationStack.add(0, str(sin(number)));
        }
      }
      
      // If the evaluationStack size is less than 2, the reverse polish expression must be invalid
      if (evaluationStack.size() >= 2) {

        float rightNumber = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        float leftNumber = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        //println(output);
        
        // Check what type of operation is being performed, and add the number back to the evaluation stack
        if (output.equals("+")) {
          evaluationStack.add(0, str(leftNumber + rightNumber));
        } else if (output.equals("-")) {
          evaluationStack.add(0, str(leftNumber - rightNumber));
        } else if (output.equals("*")) {
          evaluationStack.add(0, str(leftNumber * rightNumber));
        } else if (output.equals("/")) {
          evaluationStack.add(0, str(leftNumber / rightNumber));
        } else if (output.equals("^")) {
          evaluationStack.add(0, str(pow(leftNumber, rightNumber)));
        } else if (output.equals("sin")) {
          evaluationStack.add(0, str(sin(rightNumber)));
          evaluationStack.add(0, str(leftNumber));
        }
        
        
      }
    }
  }
  
  
  return float(evaluationStack.get(0));
}
