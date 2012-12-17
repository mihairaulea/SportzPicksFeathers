package view 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.themes.SportzPicksTheme;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.SportzPicksTheme;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import view.screens.*;
	import view.util.Assets;
	import view.util.ContentManipulator;
	import com.gskinner.motion.easing.Cubic;
	import view.util.ContentRequester;
	import view.util.ContentTransition;
	
	public class View extends Sprite
	{
		
		private static const WELCOME_SCREEN:String = "welcomeScreen";
		private static const FACEBOOK_SINGUP_SCREEN:String = "facebookSingupScreen";
		private static const EMAIL_SIGNUP_SCREEN:String = "emailSignupScreen";
		private static const HEAD_TO_HEAD_SCREEN:String = "headToHeadScreen";
		private static const LOBBY_SCREEN:String = "lobbyScreen";
		
		private var navigator:ScreenNavigator;
		private var transitionManager:ScreenSlidingStackTransitionManager;
		
		public function View() 
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage(e:Event):void
		{
			Assets.contentScaleFactor = Starling.current.contentScaleFactor;
			var theme:SportzPicksTheme = new SportzPicksTheme(stage);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.navigator = new ScreenNavigator();
			this.addChild(navigator);
			
			this.navigator.addScreen(WELCOME_SCREEN, new ScreenNavigatorItem(new WelcomeScreen(),
			{
				onFacebook: FACEBOOK_SINGUP_SCREEN,
				onEmail   : EMAIL_SIGNUP_SCREEN
			}
			
			) );
			
			
			this.navigator.addScreen(EMAIL_SIGNUP_SCREEN, new ScreenNavigatorItem(new EmailSignupScreen(),
			{
				EmailValidated: LOBBY_SCREEN
			}
			
			) );
			
			this.navigator.addScreen(LOBBY_SCREEN, new ScreenNavigatorItem(new LobbyScreen(),
			{
				onChallengerSelected: HEAD_TO_HEAD_SCREEN
			}
			
			) );
			
			this.navigator.addScreen(HEAD_TO_HEAD_SCREEN, new ScreenNavigatorItem(new HeadToHeadScreen(),
			{
				onEmailValidated: LOBBY_SCREEN
			}
			
			) );
			
			this.navigator.showScreen(WELCOME_SCREEN);
			
			
			this.transitionManager = new ScreenSlidingStackTransitionManager(navigator);
			//this.transitionManager.duration = 0.4;
			//this.transitionManager.ease = Cubic.easeOut;
		}		
		
	}

}