# PingNest

> A real-time group messaging app built for fast, focused team and friend communication.

---

## Overview

PingNest is a real-time chat app designed for small groups and teams. Users create or join chat rooms, send messages with text and media, and see who's online. It supports direct messages, group channels, message reactions, and push notifications for unread messages.

---

## Problem

General-purpose messaging apps carry too much context and noise. Teams and close-knit groups need a simple, fast messaging experience without the complexity of enterprise tools or the distraction of consumer super-apps.

---

## Solution

PingNest keeps communication lean: channels, DMs, reactions, and real-time presence — nothing more. Firebase Realtime Database provides sub-second message delivery, and FCM delivers push notifications when users aren't in the app.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | React Native 0.74 (TypeScript) |
| Auth | Firebase Authentication (email + Google + Anonymous) |
| Real-time Messaging | Firebase Realtime Database |
| File Storage | Firebase Cloud Storage |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| Chat UI | react-native-gifted-chat |
| Navigation | React Navigation v6 |
| State | Context API + useReducer |
| Media | react-native-image-picker |
| Presence | Firebase Realtime Database (`.info/connected`) |

---

## Features

**Core**
- Create named group channels with description and optional invite-only toggle
- Direct messages: open a 1:1 conversation from any user profile
- Send text messages with URL auto-linking
- Photo and file attachments via image picker with upload progress
- Message reactions: tap-hold to add emoji reaction; reaction counts shown per message
- Read receipts on DMs (delivered / seen indicators)
- Online presence indicator on user avatars (green dot)

**Backend & Infrastructure**
- Firebase Auth with email/password, Google OAuth, and anonymous guest mode; guests prompted to register to retain history
- Firebase Realtime Database structure: `/channels/{id}/messages`, `/dms/{threadId}/messages`, `/users/{uid}/online` — all secured with Realtime Database Rules
- Database rules enforce: only channel members may read messages; only authenticated users may write; message author ID must match `auth.uid` on write
- Firebase Realtime Database presence system: client writes `{online: true, last_seen: ServerValue.TIMESTAMP}` on connect, cleared via `onDisconnect()` handler
- Firebase Cloud Storage for media: files stored at `/attachments/{channelId}/{messageId}/{filename}` with Storage rules restricting to channel members
- FCM push notification triggered by a Firebase Cloud Function on new message insert: reads recipient's FCM token from Firestore and sends notification with channel name and sender
- Firebase Cloud Functions: `onNewMessage` (sends FCM), `onUserDeleted` (cleans up messages and media), `buildUnreadCounts` (updates unread badge per user)

**Notifications & UX**
- FCM foreground and background notifications; tapping opens directly to the relevant channel or DM thread
- In-app notification badge on channel list for unread counts
- Message pagination — loads last 50 messages on open, older messages loaded on scroll-up
- Swipe-to-reply quoting the original message
- Animated typing indicator when another user is composing

**Offline & Reliability**
- Firebase Realtime Database offline mode enabled: messages queued locally and sent when connectivity restores
- Reconnect indicator banner when the app loses Firebase connection
- Exponential backoff on Realtime Database reconnect

---

## Challenges

- Building reliable unread message counts in Firebase Realtime Database without server-side aggregation support
- Preventing duplicate FCM notifications when a user has multiple active devices
- Implementing message pagination with react-native-gifted-chat's inverted list and Firebase cursored queries

---

## Screenshots

_Channel List · Chat Thread · DM · User Profile_
