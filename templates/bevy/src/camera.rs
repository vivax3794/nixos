//! Code for controling the camera
use bevy::prelude::*;

use crate::prelude::*;


/// Main camera
#[derive(Component)]
struct MainCamera;

/// Construct a main camera
pub struct CameraPlugin;

impl Plugin for CameraPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Startup, spawn_camera);
    }
}

/// Spawn the setup camera
fn spawn_camera(mut commands: Commands) {
    commands.spawn(Camera2dBundle::new_with_far(ZOrdering::Camera.into()));
}
