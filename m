Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-io1-f48.google.com ([209.85.166.48]:33023 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeKOUy0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Nov 2018 15:54:26 -0500
Received: by mail-io1-f48.google.com with SMTP id f12-v6so14127860iog.0
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2018 02:47:07 -0800 (PST)
MIME-Version: 1.0
From: Mohsen Alizadeh Noghani <m.alizad3h@gmail.com>
Date: Thu, 15 Nov 2018 14:16:57 +0330
Message-ID: <CADCeSy9FW1Xj=0JDftNM577JoBG_YcbhrAWaJttWCMSacr0VeA@mail.gmail.com>
Subject: Best practices for passing messages from the RT to a non-RT process?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hello everyone.
This is a general question.
I would like to pass data from my real-time process, the only process
that runs on an isolated core (at 1 KHz+) to another, non-real-time
process. Basically, I'm receiving the position of motors of a robot in
the real-time process and must pass that data to another process for
plotting a graph.
Obviously, any IPC mechanism that would cause unbounded latency in the
real-time loop is off-limits.
What are some available solutions that don't break the real-time loop?
I've read a lot about POSIX "mqueue". Does anyone have any experience with that?
Best,
Mohsen
