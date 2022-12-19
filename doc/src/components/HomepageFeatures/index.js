import React from "react";
import clsx from "clsx";
import styles from "./styles.module.css";

const FeatureList = [
  {
    title: "Flutter UI Components",
    src: require("@site/static/img/ui.png").default,
    description: (
      <>
        Pick and choose from our highly customizable messaging widgets to
        include the exact functionality you need. Or easily build your own UI
        components by interacting with our core classes.
      </>
    ),
  },
  {
    title: "Core Controllers and Business Logic",
    src: require("@site/static/img/logic.png").default,
    description: (
      <>
        The Flutter Package includes core controllers and widgets to simplify
        business logic and state management. They handle the heavy lifting,
        allowing you to focus on the fun part - building your messaging
        experience.
      </>
    ),
  },
  {
    title: "Attachments",
    src: require("@site/static/img/documents.png").default,
    description: (
      <>
        By default we provide Gallery Image, Camera Image and Current Location.
        More coming soon...
      </>
    ),
  },
  {
    title: "Realtime Events",
    src: require("@site/static/img/clock.png").default,
    description: (
      <>
        New messages, Online status, Typing indicators, Unread messages,
        Notifications etc..
      </>
    ),
  },
  {
    title: "Localization and Themes",
    src: require("@site/static/img/language.png").default,
    description: (
      <>
        You can easily add your own localizations and themes to fit your
        designs.
      </>
    ),
  },
  {
    title: "Local Data Persistence",
    src: require("@site/static/img/wifi.png").default,
    description: (
      <>
        We provide full offline support to your chat application. View all
        messages, regardless of connectivity state, and automatically resend
        failed messages when a connection is reestablished.
      </>
    ),
  },
];

function Feature({ src, title, description }) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        <img src={src} height={100} widgets={100} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
