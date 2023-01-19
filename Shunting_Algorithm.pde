String test = "1+(2*3-1)-2";


float shuntingAlgorithm(String equation) {
  int number;
  boolean isNumber;
  ArrayList<String> outputQueue = new ArrayList<String>();
  ArrayList<String> operatorStack = new ArrayList<String>();
  
  // Making a hashmap of priorities for the algorithm to work
  HashMap<String, Integer> priorities = new HashMap<String, Integer>(); 
  priorities.put("(", 0);
  priorities.put("[", 0);
  priorities.put("+", 1);
  priorities.put("-", 1);
  priorities.put("*", 2);
  priorities.put("/", 2);
  priorities.put("^", 3);
  priorities.put(")", 4);
  priorities.put("]", 4);
  
  
  // Goes through each character in the equation
  for(int i = 0; i < equation.length(); i++) {
    char character = equation.charAt(i);
    
    // If the character isnt just a blank space
    if(!str(character).equals(" ")){
      
      // Try converting the character to an integer to check if it is an integer
      isNumber = isInteger(character);
      
      // If the character is a number, find the whole number before pushing it into the output queue
      if(isNumber) {
        int pos = i;
        
        // If the next character is still a number or a decimal character, continue to the next character
        while(isInteger(equation.charAt(pos)) || equation.charAt(pos) == '.') {
          pos++;
          
          if(pos == equation.length()) {
            break;
          }
        }
        
        // Add the whole number to the output queue
        outputQueue.add(equation.substring(i, pos));
        i = pos-1;
        println("output:", outputQueue);
      }
      
      // If the character is not a number, but an operator or function
      else {
        
        // If the operator is a left parenthesis, always add it to the operator stack
        if(priorities.get(str(character)) == 0) {
          operatorStack.add(0, str(character));
        }
        
        else if(operatorStack.size() == 0 ) {
          operatorStack.add(0, str(character));
        }
        
        // If the character is a right bracket, pop all the operators into the output queue up to the left bracket
        else if(priorities.get(str(character)) == priorities.get(")")) {
          while  (priorities.get(operatorStack.get(0)) != 0) {
            
            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);
            
            // Prevents a null pointer exception
            if(operatorStack.size() == 0) {
              break;
            }
          }
          operatorStack.remove(0);
        }
        
        // If the character operator has a higher priority than the one in stack, add it to the operator stack. 
        else if(priorities.get(operatorStack.get(0)) < priorities.get(str(character))) {
          operatorStack.add(0, str(character));
        } 
        
        // If the character has equal or lower priority than the one in stack, add it to the output queue
        else {
          while (priorities.get(str(character)) <= priorities.get(operatorStack.get(0))) {
            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);
            
            // Prevents a null pointer exception
            if(operatorStack.size() == 0) {
              break;
            }
          }
          operatorStack.add(0, str(character));
        }
        println(operatorStack);
      }
    }
  }
  
  // If there are still characters left in the operatorStack array
  if(operatorStack.size() != 0) {
    // Append them to the output array
    for(int i = 0; i < operatorStack.size(); i++) {
      outputQueue.add(operatorStack.get(0));
      operatorStack.remove(0);
    }
  }
  
  println(outputQueue);
  
  return 0.1;
}
