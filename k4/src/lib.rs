// K4 Programming Language - Library Entry Point

pub mod ast;
pub mod codegen;
pub mod lexer;
pub mod parser;
pub mod quantum;
pub mod typechecker;
pub mod ai_integration;
pub mod distributed;

// Re-export commonly used items
pub use ast::{Expression, Statement, Program};
pub use lexer::{Lexer, Token, TokenType};
pub use quantum::{QuantumCircuit, QuantumGate, QuantumRegister, Qubit};
pub use ai_integration::{AIModel, ModelType, AIValue};

// Version information
pub const VERSION: &str = env!("CARGO_PKG_VERSION");
pub const NAME: &str = env!("CARGO_PKG_NAME");
pub const DESCRIPTION: &str = env!("CARGO_PKG_DESCRIPTION");

// Compile a K4 source file to an executable
pub fn compile(source: &str, output_path: &str) -> Result<(), String> {
    println!("Compiling K4 source to: {}", output_path);
    
    // Create lexer
    let lexer = lexer::Lexer::new(source.to_string());
    
    // TODO: Implement actual compilation
    
    Ok(())
}

// Parse a K4 source file to an AST
pub fn parse(source: &str) -> Result<ast::Program, String> {
    // Create lexer
    let lexer = lexer::Lexer::new(source.to_string());
    
    // TODO: Implement actual parsing
    
    Ok(ast::Program { statements: vec![] })
}

// Execute a K4 program directly
pub fn execute(source: &str) -> Result<(), String> {
    println!("Executing K4 program...");
    
    // Parse the source
    let program = parse(source)?;
    
    // TODO: Implement actual execution
    
    Ok(())
}

// Type check a K4 program
pub fn typecheck(program: &ast::Program) -> Result<(), String> {
    println!("Type checking K4 program...");
    
    // TODO: Implement actual type checking
    
    Ok(())
}