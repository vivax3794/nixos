//! Code for controling the camera
use bevy::prelude::*;
use bevy_ecs_ldtk::prelude::*;

use crate::prelude::*;

/// Construct a world
pub struct WorldPlugin;

impl Plugin for WorldPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins(LdtkPlugin).insert_resource(LevelSelection::index(0));
        app.add_systems(Startup, spawn_world);
    }
}

/// Spawn the world
fn spawn_world(mut commands: Commands, world: Res<assets::LdtkWorld>) {
    commands.spawn(LdtkWorldBundle {
        ldtk_handle: world.world.clone(),
        ..Default::default()
    });
}
