From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Tue, 17 Dec 2013 11:40:01 -0800
Message-ID: <52B0A891.8030905@localhost>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de> <529A6AFD.9020308@osadl.org> <20131215145325.GH31090@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.219.83]:40735 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752906Ab3LQTk1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Dec 2013 14:40:27 -0500
In-Reply-To: <20131215145325.GH31090@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2013 06:53 AM, Sebastian Andrzej Siewior wrote:
> * Carsten Emde | 2013-11-30 23:47:25 [+0100]:
>
>> Will apply the fix and the warning - let's see.
>
> I do not want to urge anyone but just gentle ping to satisfy my
> curiosity about the patch.
> Fernando, any updates from you?

Hi, I have not seen this problem again, but I have not had a chance to 
stress the system. Usually this would pop up when running jackd + audio 
applications for some time. But so far so good...

-- Fernando
