// K4 Programming Language - Lexer Module

#[derive(Debug, Clone, PartialEq)]
pub enum TokenType {
    // Keywords
    Let,
    Const,
    Fn,
    Return,
    If,
    Else,
    While,
    For,
    In,
    Break,
    Continue,
    Struct,
    Enum,
    Trait,
    Impl,
    Quantum,
    Distributed,
    AI,
    
    // Literals
    Identifier,
    IntLiteral,
    FloatLiteral,
    StringLiteral,
    BoolLiteral,
    
    // Operators
    Plus,
    Minus,
    Multiply,
    Divide,
    Modulo,
    Assign,
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,
    LessThanEqual,
    GreaterThanEqual,
    And,
    Or,
    Not,
    
    // Delimiters
    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,
    LeftBracket,
    RightBracket,
    Semicolon,
    Colon,
    Comma,
    Dot,
    Arrow,
    
    // Special
    EOF,
    Unknown,
}

#[derive(Debug, Clone)]
pub struct Token {
    pub token_type: TokenType,
    pub lexeme: String,
    pub line: usize,
    pub column: usize,
}

pub struct Lexer {
    input: String,
    position: usize,
    read_position: usize,
    ch: char,
    line: usize,
    column: usize,
}

impl Lexer {
    pub fn new(input: String) -> Lexer {
        let mut lexer = Lexer {
            input,
            position: 0,
            read_position: 0,
            ch: '\0',
            line: 1,
            column: 0,
        };
        lexer.read_char();
        lexer
    }
    
    fn read_char(&mut self) {
        if self.read_position >= self.input.len() {
            self.ch = '\0';
        } else {
            self.ch = self.input.chars().nth(self.read_position).unwrap();
        }
        self.position = self.read_position;
        self.read_position += 1;
        self.column += 1;
    }
    
    pub fn next_token(&mut self) -> Token {
        self.skip_whitespace();
        
        let token = match self.ch {
            // TODO: Implement token recognition
            _ => Token {
                token_type: TokenType::Unknown,
                lexeme: self.ch.to_string(),
                line: self.line,
                column: self.column,
            },
        };
        
        self.read_char();
        token
    }
    
    fn skip_whitespace(&mut self) {
        while self.ch.is_whitespace() {
            if self.ch == '\n' {
                self.line += 1;
                self.column = 0;
            }
            self.read_char();
        }
    }
    
    // TODO: Implement methods for recognizing different token types
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_lexer() {
        // TODO: Implement lexer tests
    }
}