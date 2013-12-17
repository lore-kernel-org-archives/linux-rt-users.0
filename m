From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Tue, 17 Dec 2013 20:42:57 +0100
Message-ID: <52B0A941.9070702@linutronix.de>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de> <529A6AFD.9020308@osadl.org> <20131215145325.GH31090@linutronix.de> <52B0A891.8030905@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40416 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3LQTnF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Dec 2013 14:43:05 -0500
In-Reply-To: <52B0A891.8030905@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/17/2013 08:40 PM, Fernando Lopez-Lezcano wrote:
>> Fernando, any updates from you?
> 
> Hi, I have not seen this problem again, but I have not had a chance to
> stress the system. Usually this would pop up when running jackd + audio
> applications for some time. But so far so good...

Okay, but you are using the patch I posted correct? And without the
patch you were able to reproduce it more than once?

> 
> -- Fernando

Sebastian
