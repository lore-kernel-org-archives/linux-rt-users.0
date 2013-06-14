From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: pagefaults ...
Date: Fri, 14 Jun 2013 07:18:27 +0200
Message-ID: <CAF-VNaq1UQQW7MZUQ5N7nmvF_FFboXr4yn8CHaMzUGL6qndQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58169 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab3FNFS2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Jun 2013 01:18:28 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so200531pbc.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2013 22:18:28 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi,

 I have an application which should be realtime but apparently
generates page faults from a realtime context, I am trying to find a
way to get a stacktrace when this occurs, does anybody have any ideas
?

 I verified with some other testcases that the system actually looks
fine. And I would prefer to know where to look before I dive into the
code.

 I looked at ftrace and perf but haven't figured out how to get a
trace from the app, but I figured this must have occured before so I
better ask first.

 Any hints would be most appreciated !

 / regards, Lars Segerlund.
