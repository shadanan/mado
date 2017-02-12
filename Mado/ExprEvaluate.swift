//
//  MadoExprEvaluate.swift
//  Mado
//
//  Created by Shad Sharma on 2/5/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Antlr4
import Foundation

class Expr: MadoVisitor<Double> {
    let W: Double
    let H: Double
    let x: Double
    let y: Double
    let w: Double
    let h: Double
    
    var msg: String?
    var error: ANTLRError? = nil
    
    init(W: Double, H: Double, x: Double, y: Double, w: Double, h: Double) {
        self.W = W
        self.H = H
        self.x = x
        self.y = y
        self.w = w
        self.h = h
    }
    
    class MadoErrorListener: ANTLRErrorListener {
        let expr: Expr

        init(expr: Expr) {
            self.expr = expr
        }

        func syntaxError<T : ATNSimulator>(_ recognizer: Recognizer<T>, _ offendingSymbol: AnyObject?, _ line: Int, _ charPositionInLine: Int, _ msg: String, _ e: AnyObject?) {
            expr.error = ANTLRError.illegalArgument(msg: msg)
        }
        
        func reportAmbiguity(_ recognizer: Parser, _ dfa: DFA, _ startIndex: Int, _ stopIndex: Int, _ exact: Bool, _ ambigAlts: BitSet, _ configs: ATNConfigSet) throws {
        }
        
        func reportContextSensitivity(_ recognizer: Parser, _ dfa: DFA, _ startIndex: Int, _ stopIndex: Int, _ prediction: Int, _ configs: ATNConfigSet) throws {
        }
        
        func reportAttemptingFullContext(_ recognizer: Parser, _ dfa: DFA, _ startIndex: Int, _ stopIndex: Int, _ conflictingAlts: BitSet?, _ configs: ATNConfigSet) throws {
        }
    }
    
    override func visitNumber(_ ctx: MadoParser.NumberContext) -> Double {
        return Double(ctx.getText())!
    }
    
    override func visitAtomNumberExpr(_ ctx: MadoParser.AtomNumberExprContext) -> Double {
        return visitChildren(ctx)!
    }
    
    override func visitVariable(_ ctx: MadoParser.VariableContext) -> Double {
        switch ctx.getText() {
        case "W": return W
        case "H": return H
        case "x": return x
        case "y": return y
        case "w": return w
        case "h": return h
        default:
            error = ANTLRError.illegalState(msg: "Invalid Variable: \(ctx.getText())")
            return 0
        }
    }
    
    override func visitAtomVariableExpr(_ ctx: MadoParser.AtomVariableExprContext) -> Double {
        return visitChildren(ctx)!
    }
    
    override func visitOperatorExpr(_ ctx: MadoParser.OperatorExprContext) -> Double {
        if let lop = visit(ctx.lop), let rop = visit(ctx.rop), let op = ctx.op.getText() {
            switch op {
            case "*": return lop * rop
            case "/": return lop / rop
            case "+": return lop + rop
            case "-": return lop - rop
            default:
                error = ANTLRError.illegalState(msg: "Invalid Operator: \(op)")
            }
        }
        
        return 0
    }
    
    override func visitMultiplyExpr(_ ctx: MadoParser.MultiplyExprContext) -> Double {
        return visit(ctx.number()!)! * visit(ctx.variable()!)!
    }
    
    override func visitParenExpr(_ ctx: MadoParser.ParenExprContext) -> Double {
        return visit(ctx.expr()!)!
    }
    
    static func evaluate(exprStr: String, W: Double, H: Double,
                         x: Double, y: Double, w: Double, h: Double) -> Double? {
        do {
            let lexer = MadoLexer(ANTLRInputStream(exprStr))
            let parser = try MadoParser(CommonTokenStream(lexer))
            parser.setErrorHandler(BailErrorStrategy())
            let visitor = Expr(W: W, H: H, x: x, y: y, w: w, h: h)
            lexer.addErrorListener(MadoErrorListener(expr: visitor))
            let expr = try parser.expr()
            
            if visitor.error != nil {
                return nil
            }
            
            if let result = visitor.visit(expr) {
                return result
            }
        } catch {}

        return nil
    }
}
