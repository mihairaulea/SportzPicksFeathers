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
		private static const EMAIL_SIGNUP_SCREEN:String = "emailSignupScreen";
		private static const HEAD_TO_HEAD_SCREEN:String = "headToHeadScreen";
		private static const LOBBY_SCREEN:String = "lobbyScreen";
		
		private static const EMAIL_OPPONENT_SCREEN:String = "emailOpponentScreen";
		private static const FACEBOOK_FRIENDS_SCREEN:String = "facebookFriendsScreen";
		private static const NEW_GAME_SCREEN:String = "newGameScreen";
		private static const POPULAR_EVENTS_SCREEN:String = "popularEventsScreen";
		private static const SELECT_EVENT_SCREEN:String = "selectEventScreen";
		private static const SELECT_SPORT_SCREEN:String = "selectSportScreen";
		
		private var navigator:ScreenNavigator;
		private var transitionManager:ScreenSlidingStackTransitionManager;
		
		public function View() 
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage(e:Event):void
		{
			Assets.contentScaleFactor = Starling.current.contentScaleFactor;
			//var theme:SportzPicksTheme = new SportzPicksTheme(stage);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.navigator = new ScreenNavigator();
			this.addChild(navigator);
						
			this.navigator.addScreen(WELCOME_SCREEN, new ScreenNavigatorItem(new WelcomeScreen(),
			{
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
				onBack: LOBBY_SCREEN
			}			
			)
			);
			
			this.navigator.addScreen(EMAIL_OPPONENT_SCREEN, new ScreenNavigatorItem(new EmailOpponentScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.addScreen(FACEBOOK_FRIENDS_SCREEN, new ScreenNavigatorItem(new FacebookFriendsScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.addScreen(NEW_GAME_SCREEN, new ScreenNavigatorItem(new NewGameScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.addScreen(POPULAR_EVENTS_SCREEN, new ScreenNavigatorItem(new PopularEventsScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.addScreen(SELECT_EVENT_SCREEN, new ScreenNavigatorItem(new SelectEventScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.addScreen(SELECT_SPORT_SCREEN, new ScreenNavigatorItem(new SelectSportScreen(),
			{
				onBack: LOBBY_SCREEN
			}
			)
			);
			
			this.navigator.showScreen(WELCOME_SCREEN);
			//this.navigator.showScreen(EMAIL_SIGNUP_SCREEN);
			//this.navigator.showScreen(LOBBY_SCREEN);
			//this.navigator.showScreen(HEAD_TO_HEAD_SCREEN);
			// batch 2
			//this.navigator.showScreen(EMAIL_OPPONENT_SCREEN);
			//this.navigator.showScreen(FACEBOOK_FRIENDS_SCREEN);
			//this.navigator.showScreen(NEW_GAME_SCREEN);
			//this.navigator.showScreen(POPULAR_EVENTS_SCREEN);
			//this.navigator.showScreen(SELECT_EVENT_SCREEN);
			//this.navigator.showScreen(SELECT_SPORT_SCREEN);
			
			this.transitionManager = new ScreenSlidingStackTransitionManager(navigator);
			//this.transitionManager.duration = 0.4;
			//this.transitionManager.ease = Cubic.easeOut;
		}		
		
	}

}