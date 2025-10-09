pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    
    // --- Core Audio Properties ---
    property real volumeLevel: sink?.audio?.volume ?? 0.0
    property bool isMuted: sink?.audio?.mute ?? false
    property bool ready: sink?.ready ?? false
    
    // Pipewire sink and source
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    
    // Track sink changes
    PwObjectTracker {
        objects: [sink, source]
    }
    
    // Connections for real-time updates
    Connections {
        target: sink?.audio ?? null
        function onVolumeChanged() {
            root.volumeLevel = sink.audio.volume
        }
        function onMuteChanged() {
            root.isMuted = sink.audio.mute
        }
    }
    
    // Function to set volume (0.0 to 1.0)
    function setVolume(level) {
        if (sink?.audio) {
            sink.audio.volume = Math.max(0, Math.min(1, level))
        }
    }
    
    // Function to toggle mute
    function toggleMute() {
        if (sink?.audio) {
            sink.audio.mute = !sink.audio.mute
        }
    }
}
