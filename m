From: Jonah Petri <jpetri@izotope.com>
Subject: diagnosing unexpected sched_stat_wait
Date: Fri, 4 Mar 2016 14:15:25 -0500
Message-ID: <CAJOrw7was05Absp0UiCVO5mZEoZqXHD-ZNOoDwoG7t1S1DED_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36126 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759867AbcCDTP1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2016 14:15:27 -0500
Received: by mail-ob0-f169.google.com with SMTP id rt7so58399567obb.3
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Mar 2016 11:15:26 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

My application is doing realtime low-latency audio, and we're seeing
occasional dropouts, which we've traced (via ftrace) to an unexplained
sched_stat_wait event on our audio-handling user thread.

We're really not sure what might be causing this, but if I could get
the user stack trace causing this event, it would let me see exactly
the problem.  Even the top frame of the stack would be invaluable.

Is there a way to get this info?  Preferrably with ftrace, but any
methods or hints would be much appreciated.

Thanks!
Jonah
