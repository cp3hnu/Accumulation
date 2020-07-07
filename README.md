# Accumulation

开发过程中项目积累，包括View, View Controller, Extension, Style, Transition

## Installation

1.  Add Accumulation as a [submodule](http://git-scm.com/docs/git-submodule)

    ```swift
    cd top-level project directory
    git submodule add https://github.com/cp3hnu/Accumulation.git
    ```

2.  Open the `Accumulation` folder, and drag `Accumulation.xcodeproj` into the file navigator of your app project.

3.  In Xcode, selecting the application target under the "Targets" heading in the sidebar.

4.  Ensure that the deployment target of `Accumulation.framework` matches that of the application target.

5.  In the tab bar at the top of that window, open the "Build Phases" panel.

6.  Expand the "Target Dependencies" group, and add `Accumulation.framework`.

7.  Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `Accumulation.framework`.

