Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50231 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeFFNb4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [v4.9 RT 0/6] futex backports
Date: Wed,  6 Jun 2018 15:31:25 +0200
Message-Id: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

Hi Julia,

as mentioned in the stable meeting, here is the futex patch that was
missing in the v4.9 tree :)
The futex state in v4.9 was backported from a later kernel at the time
Peter made the patches. That is why all the fixes which were tagged
stable did not enter the v4.9 stable tree.
I had a "deadlock assert in glibc" from pthread_mutex_lock() which did
not make a lot of sense. After comparing the futex code in latest v4.9
and v4.14 I identified a few patches which should be backported.
I haven't seen the issue after applying the patches which follow as a
reply to this email. They apply on top of v4.9.98-rt76.

Sebastian


