Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lebib.org ([89.234.152.46]:57162 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbeKILFM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Nov 2018 06:05:12 -0500
Received: from fetide (83.202.115.78.rev.sfr.net [78.115.202.83])
        by lebib.org (Postfix) with ESMTPSA id F06124928681
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Nov 2018 02:17:36 +0100 (CET)
Message-ID: <b02df6ecde63bbdaafaeb7b3aa672ddbb2634f8b.camel@lebib.org>
Subject: Hang at suspend with 4.18.0-2 rt
From: wargreen <wargreen@lebib.org>
Date: Fri, 09 Nov 2018 02:17:34 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hello rt list,

Since the 4.18.0-2 upgrade from debian repo, i have a full system hang
when my thinkpad x230 go to suspend. No problem with 4.17 or 4.18.0-2
no-rt.

I havn't anything in the logs. The only visible thing is the fast
blinking power led, as when the computer go to or resume from suspend.

I can do some tests if needed.

Cheers,
wargreen
