#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut stack: Vec<i32> = vec![];
    for input in inputs {
        match input {
            CalculatorInput::Value(v) => stack.push(*v),
            _ => {
                if stack.len() < 2 {
                    return None
                }
                let b = stack.pop().unwrap();
                let a = stack.pop().unwrap();
                match input {
                    CalculatorInput::Add => stack.push(a + b),
                    CalculatorInput::Subtract => stack.push(a - b),
                    CalculatorInput::Multiply => stack.push(a * b),
                    CalculatorInput::Divide => stack.push(a / b),
                    _ => return None
                }
            }
        };
    }
    if stack.len() > 1 { None } else { stack.pop() }
}
