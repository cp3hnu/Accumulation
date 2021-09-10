# Accumulation

开发项目过程中的积累，包括View, View Controller, Extension, Transition, Style, Utils

## Installation

#### Submodule

1.  Add Accumulation as a [submodule](http://git-scm.com/docs/git-submodule)

    ```swift
    cd top-level project directory
    git submodule add https://github.com/cp3hnu/Accumulation.git
    ```

2. Open the `Accumulation` folder, and drag `Accumulation.xcodeproj` into the file navigator of your app project.

3. In Xcode, selecting the application target under the "Targets" heading in the sidebar.

4. Add `Accumulation.framework` in "Framework, Libraries, and Embedded Content" and select "Embed & Sign" in "Embed".

5. Expand the "Target Dependencies" group, and add `Accumulation.framework`.

> NOTE：This project depends on `RxSwift` and `Bricking`，you don't need to add `RxSwift` and `Bricking` dependencies in your project.

> NOTE：This project depends on `RxSwift` and `Bricking`，if your project or other frameworks  depend on  `RxSwift` and `Bricking`, this will cause `CFBundleIdentifier Collision`. 
>
> You can add `Accumulation` as local package to your project, as follow.

#### Local Package

To add the Swift package as local package to your project:

1. Check out your package dependency’s source code from its Git repository. 
2. Open your app’s Xcode project or workspace.
3. Select the Swift package’s folder in Finder and drag it into the Project navigator. This action adds your dependency’s Swift package as a local package to your project.
4. Make changes to the local package and your app, then verify them by building and running your app.
5. When you’re done editing the local package, push your changes to its remote Git repository.
6. When the changes have made it into the package’s next release, remove the local package from your project, and update the package dependency to the new version.

