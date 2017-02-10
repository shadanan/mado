// Generated from Mado.g4 by ANTLR 4.6
import Antlr4

open class MadoParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MadoParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(MadoParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()
	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public enum Tokens: Int {
		case EOF = -1, T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, 
                 Number = 7, Variable = 8, WHITESPACE = 9
	}
	public static let RULE_expr = 0, RULE_number = 1, RULE_variable = 2
	public static let ruleNames: [String] = [
		"expr", "number", "variable"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'('", "')'", "'*'", "'/'", "'+'", "'-'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, "Number", "Variable", "WHITESPACE"
	]
	public static let VOCABULARY: Vocabulary = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	//@Deprecated
	public let tokenNames: [String?]? = {
	    let length = _SYMBOLIC_NAMES.count
	    var tokenNames = [String?](repeating: nil, count: length)
		for i in 0..<length {
			var name = VOCABULARY.getLiteralName(i)
			if name == nil {
				name = VOCABULARY.getSymbolicName(i)
			}
			if name == nil {
				name = "<INVALID>"
			}
			tokenNames[i] = name
		}
		return tokenNames
	}()

	override
	open func getTokenNames() -> [String?]? {
		return tokenNames
	}

	override
	open func getGrammarFileName() -> String { return "Mado.g4" }

	override
	open func getRuleNames() -> [String] { return MadoParser.ruleNames }

	override
	open func getSerializedATN() -> String { return MadoParser._serializedATN }

	override
	open func getATN() -> ATN { return MadoParser._ATN }

	open override func getVocabulary() -> Vocabulary {
	    return MadoParser.VOCABULARY
	}

	public override init(_ input:TokenStream)throws {
	    RuntimeMetaData.checkVersion("4.6", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,MadoParser._ATN,MadoParser._decisionToDFA, MadoParser._sharedContextCache)
	}
	open class ExprContext:ParserRuleContext {
		open override func getRuleIndex() -> Int { return MadoParser.RULE_expr }
	 
		public  func copyFrom(_ ctx: ExprContext) {
			super.copyFrom(ctx)
		}
	}
	public  final class AtomVariableExprContext: ExprContext {
		open func variable() -> VariableContext? {
			return getRuleContext(VariableContext.self,0)
		}
		public init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitAtomVariableExpr(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitAtomVariableExpr(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public  final class AtomNumberExprContext: ExprContext {
		open func number() -> NumberContext? {
			return getRuleContext(NumberContext.self,0)
		}
		public init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitAtomNumberExpr(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitAtomNumberExpr(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public  final class OperatorExprContext: ExprContext {
		public var lop: ExprContext!
		public var op: Token!
		public var rop: ExprContext!
		open func expr() -> Array<ExprContext> {
			return getRuleContexts(ExprContext.self)
		}
		open func expr(_ i: Int) -> ExprContext? {
			return getRuleContext(ExprContext.self,i)
		}
		public init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitOperatorExpr(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitOperatorExpr(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public  final class MultiplyExprContext: ExprContext {
		open func number() -> NumberContext? {
			return getRuleContext(NumberContext.self,0)
		}
		open func variable() -> VariableContext? {
			return getRuleContext(VariableContext.self,0)
		}
		public init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitMultiplyExpr(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitMultiplyExpr(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public  final class ParenExprContext: ExprContext {
		open func expr() -> ExprContext? {
			return getRuleContext(ExprContext.self,0)
		}
		public init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitParenExpr(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitParenExpr(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}

	public final  func expr( ) throws -> ExprContext   {
		return try expr(0)
	}
	@discardableResult
	private func expr(_ _p: Int) throws -> ExprContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ExprContext = ExprContext(_ctx, _parentState)
		var  _prevctx: ExprContext = _localctx
		var _startState: Int = 0
		try enterRecursionRule(_localctx, 0, MadoParser.RULE_expr, _p)
		var _la: Int = 0
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(16)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,0, _ctx)) {
			case 1:
				_localctx = ParenExprContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx

				setState(7)
				try match(MadoParser.Tokens.T__0.rawValue)
				setState(8)
				try expr(0)
				setState(9)
				try match(MadoParser.Tokens.T__1.rawValue)

				break
			case 2:
				_localctx = MultiplyExprContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx
				setState(11)
				try number()
				setState(12)
				try variable()

				break
			case 3:
				_localctx = AtomNumberExprContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx
				setState(14)
				try number()

				break
			case 4:
				_localctx = AtomVariableExprContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx
				setState(15)
				try variable()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(26)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,2,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					setState(24)
					try _errHandler.sync(self)
					switch(try getInterpreter().adaptivePredict(_input,1, _ctx)) {
					case 1:
						_localctx = OperatorExprContext(  ExprContext(_parentctx, _parentState))
						(_localctx as! OperatorExprContext).lop = _prevctx
						try pushNewRecursionContext(_localctx, _startState, MadoParser.RULE_expr)
						setState(18)
						if (!(precpred(_ctx, 4))) {
						    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 4)"))
						}
						setState(19)
						_localctx.castdown(OperatorExprContext.self).op = try _input.LT(1)
						_la = try _input.LA(1)
						if (!(//closure
						 { () -> Bool in
						      let testSet: Bool = _la == MadoParser.Tokens.T__2.rawValue || _la == MadoParser.Tokens.T__3.rawValue
						      return testSet
						 }())) {
							_localctx.castdown(OperatorExprContext.self).op = try _errHandler.recoverInline(self) as Token
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(20)
						try {
								let assignmentValue = try expr(5)
								_localctx.castdown(OperatorExprContext.self).rop = assignmentValue
						     }()


						break
					case 2:
						_localctx = OperatorExprContext(  ExprContext(_parentctx, _parentState))
						(_localctx as! OperatorExprContext).lop = _prevctx
						try pushNewRecursionContext(_localctx, _startState, MadoParser.RULE_expr)
						setState(21)
						if (!(precpred(_ctx, 3))) {
						    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 3)"))
						}
						setState(22)
						_localctx.castdown(OperatorExprContext.self).op = try _input.LT(1)
						_la = try _input.LA(1)
						if (!(//closure
						 { () -> Bool in
						      let testSet: Bool = _la == MadoParser.Tokens.T__4.rawValue || _la == MadoParser.Tokens.T__5.rawValue
						      return testSet
						 }())) {
							_localctx.castdown(OperatorExprContext.self).op = try _errHandler.recoverInline(self) as Token
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(23)
						try {
								let assignmentValue = try expr(4)
								_localctx.castdown(OperatorExprContext.self).rop = assignmentValue
						     }()


						break
					default: break
					}
			 
				}
				setState(28)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,2,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class NumberContext:ParserRuleContext {
		open func Number() -> TerminalNode? { return getToken(MadoParser.Tokens.Number.rawValue, 0) }
		open override func getRuleIndex() -> Int { return MadoParser.RULE_number }
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitNumber(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitNumber(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	open func number() throws -> NumberContext {
		var _localctx: NumberContext = NumberContext(_ctx, getState())
		try enterRule(_localctx, 2, MadoParser.RULE_number)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(29)
		 	try match(MadoParser.Tokens.Number.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class VariableContext:ParserRuleContext {
		open func Variable() -> TerminalNode? { return getToken(MadoParser.Tokens.Variable.rawValue, 0) }
		open override func getRuleIndex() -> Int { return MadoParser.RULE_variable }
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is MadoVisitor {
			     return (visitor as! MadoVisitor<T>).visitVariable(self)
			}else if visitor is MadoBaseVisitor {
		    	 return (visitor as! MadoBaseVisitor<T>).visitVariable(self)
		    }
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	open func variable() throws -> VariableContext {
		var _localctx: VariableContext = VariableContext(_ctx, getState())
		try enterRule(_localctx, 4, MadoParser.RULE_variable)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(31)
		 	try match(MadoParser.Tokens.Variable.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

    override
	open func sempred(_ _localctx: RuleContext?, _ ruleIndex: Int,  _ predIndex: Int)throws -> Bool {
		switch (ruleIndex) {
		case  0:
			return try expr_sempred(_localctx?.castdown(ExprContext.self), predIndex)
	    default: return true
		}
	}
	private func expr_sempred(_ _localctx: ExprContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 0:return precpred(_ctx, 4)
		    case 1:return precpred(_ctx, 3)
		    default: return true
		}
	}

   public static let _serializedATN : String = MadoParserATN().jsonString
   public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}