//! All states, and also nested state logic

use bevy::prelude::*;

use crate::prelude::*;

/// Main global state
#[derive(States, Hash, Debug, PartialEq, Eq, Default, Clone)]
pub enum MainState {
	/// Loading assets
	#[default]
	Loading,
	/// In gameplay section
	Gameplay,
}

/// Nested state managing plugin
pub struct StatePlugin;

impl Plugin for StatePlugin {
	fn build(&self, app: &mut App) {
		app.add_state::<MainState>();
	}
}

/// Create a new nested state that will be switched to when parent state enters correct state
/// and switch to default when parent state exsists.
fn add_substate<P: States + PartialEq + Eq, S: States>(app: &mut App, parent: P, sub: S) {
	app.add_state::<S>();
	let parent_clone = parent.clone();
	app.add_systems(
		Update,
		(
			move |mut commands: Commands, current_parent: Res<State<P>>| {
				if current_parent.is_changed() && current_parent.get() == &parent {
					commands.insert_resource(NextState(Some(sub.clone())));
				}
			},
			move |mut commands: Commands, current_parent: Res<State<P>>| {
				if current_parent.is_changed() && current_parent.get() != &parent_clone {
					commands.insert_resource(NextState(Some(S::default())));
				}
			},
		),
	);
}
