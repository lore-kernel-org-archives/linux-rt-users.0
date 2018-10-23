Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from afk.unpythonic.net ([138.68.55.246]:38902 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGkX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Oct 2018 02:40:23 -0400
Date: Tue, 23 Oct 2018 16:48:12 -0500
From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: system() instruction creates latency peaks
Message-ID: <20181023214812.3sqxq7w7xtnh6b2h@unpythonic.net>
References: <trinity-d772b31d-ea20-4c6d-92d9-387f0952bf76-1540308456962@3c-app-mailcom-lxa13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-d772b31d-ea20-4c6d-92d9-387f0952bf76-1540308456962@3c-app-mailcom-lxa13>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: verrodj@uymail.com
Cc: linux-rt-users@vger.kernel.org

Hi, I have experienced similar symptoms in realtime programs (LinuxCNC).
We have a control thread which sometimes does operations like system(),
and one or more realtime threads.

There, we changed from using system() to using posix_spawn and it
appears to have resolved the problem.

However, I don't have any explanation as to why this is the case.  On
the specific version of glibc I have, posix_spawn uses vfork and system
uses clone; other syscalls like rt_sigaction are taken in the system
case but not the posix_spawn case.

Jeff
