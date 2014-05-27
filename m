From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] arm: Set hardirq tracing to on when idling
Date: Tue, 27 May 2014 18:38:33 +0200
Message-ID: <5384BF89.6010509@meduna.org>
References: <1401045323-7116-1-git-send-email-minyard@acm.org> <4559339.apo3Fd10HK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: minyard@acm.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42398 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbaE0Qip (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2014 12:38:45 -0400
In-Reply-To: <4559339.apo3Fd10HK@wuerfel>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 26.05.2014 11:26, Arnd Bergmann wrote:

> It seems like the right thing to do, I just don't understand
> why nobody hit this before.

Looks like this is what I did hit a month ago and
was not able to find the culprit:
http://www.spinics.net/lists/linux-rt-users/msg11656.html

> How exactly do you see this manifest? If it's clear
> that the trace comes from the idle function, maybe
> everybody just ignores it?

That was definitely what I did ;)

-- 
                                       Stano

