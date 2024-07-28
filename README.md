### Glory to Ukraine! - Glory to the heroes!

# BrightScript Logger

---

# BrightScript Logger Integration

This project provides a simple and effective logging solution for BrightScript applications, integrated into a sample Roku app. It demonstrates how to utilize the logging system to track events, errors, and other important runtime information, making it easier to debug and maintain your BrightScript projects.

## Features

-   **Simple Integration**: Easily add logging to your existing BrightScript applications.
-   **Configurable Logging Levels**: Support for multiple logging levels such as DEBUG, INFO, WARN, ERROR, allowing for fine-grained control over log output.
-   **Customizable Output**: Logs can be directed to various outputs, including the console or external files.
-   **Lightweight**: Designed to have minimal impact on application performance.

## Getting Started

Follow these steps to integrate the logger into your BrightScript project.

### Prerequisites

-   Roku device or emulator
-   BrightScript SDK
-   Basic understanding of BrightScript and Roku development

### Installation

To install the BrightScript Logger, follow these steps:

1.  Clone or download the repository to your local machine.
2.  Open your BrightScript project in your preferred IDE.
3.  Copy the `logger.brs` folder from the repository into your project's root directory.
4.  Create script link to this brs file from the scope where you are going to use it.
5.  The best practice, as demonstrated in this sample, is to place the logger.brs file in the source/utils/ folder. This makes it accessible from the source scope. Then, add a script link like this to your component XML files:

        ```
        	<script type="text/brightscript" uri="pkg:/source/utils/logger.brs" />
        ```

    It's recommended to add this script link to base components for consistent logging across your app.
