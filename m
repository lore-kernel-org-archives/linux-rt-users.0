From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] README: Added info about setting branch --tracking
Date: Thu, 8 Jun 2017 14:17:11 +0200
Message-ID: <20170608121710.huvdfg74uprvudlj@linutronix.de>
References: <20170608101953.zkiad4lttux6yaw4@debian1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jkacur@redhat.com, rolf.freitag@email.de,
        linux-rt-users@vger.kernel.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdFHMRP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 08:17:15 -0400
Content-Disposition: inline
In-Reply-To: <20170608101953.zkiad4lttux6yaw4@debian1.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-08 11:19:55 [+0100], Piotr Gregor wrote:
> To setup remote tracking of the branch stable/v1.0
> git checkout with --track option can be used:
> 	git checkout -b stable/v1.0 --track origin/stable/v1.0
> Otherwise when git checkout -b stable/v1.0 is used
> branch may not be properly set up to track it's remote counterpart
> (given git option) and users may be confused due to no files present
> in the folder, but README.
> 
> Signed-off-by: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
