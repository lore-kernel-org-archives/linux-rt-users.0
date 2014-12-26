From: Chanchal Paul <paulchanchal.ece@gmail.com>
Subject: Help needed to implement parameter in SCHED_DEADLINE policy
Date: Fri, 26 Dec 2014 21:14:22 +0530
Message-ID: <CAD2dHrTBZd6a_QdEqh4xhVj1c-e4bzAKF5uC4N6B+UEh-zgxvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: kernelnewbies@kernelnewbies.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f68.google.com ([209.85.213.68]:63224 "EHLO
	mail-yh0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaLZPoX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Dec 2014 10:44:23 -0500
Received: by mail-yh0-f68.google.com with SMTP id z6so1965267yhz.11
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Dec 2014 07:44:22 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I am trying to implement my custom scheduling policy in rt patched
linux kernel. I am working with version 3.14.25-rt22. I have
successfully installed the kernel after patching with rt patch of same
version.

Now the installed kernel also has SCHED_DEADLINE i.e. the EDF scheduling policy.

The problem in my hand is to introduce a parameter in the
SCHED_DEADLINE policy which will further dynamically change the
priority according to the supplied value while the task is submitted.

I have already simulated and tested my requirement. I am having
problem with understanding the hierarchy of scheduler code.

Thanks in advance.
