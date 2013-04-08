From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: BUG - pthread conditional locks and barriers not reliable
Date: Mon, 8 Apr 2013 08:20:48 +0200
Message-ID: <20130408062048.GA24078@opentech.at>
References: <1364458931.4931.8.camel@debian> <1364520685.8268.2.camel@debian> <1364521778.8491.4.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Jo?l Kr?hemann <joel@weedlight.ch>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:35454 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab3DHG3o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Apr 2013 02:29:44 -0400
Content-Disposition: inline
In-Reply-To: <1364521778.8491.4.camel@debian>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 Mar 2013, Jo?l Kr?hemann wrote:

> Hi, finished with euphoria. It's an issue with pthread implementation
> may be you have to extend kernel API to fix this problem. You can't wrap
> pthread_barrier_wait with pthread_mutex_lock and pthread_mutex_unlock
> because it has a race condition what ends probably in a deadlock.
>
are you using a PI mutex ? the POSIX spec actually explicitly states that
barriers are not inversion free so for a non-PI mutex that could cause deadlocks
in combination with mutexes. If you are not using PI could you give it a shot-
if that fixes it ? 

thx!
hofrat
