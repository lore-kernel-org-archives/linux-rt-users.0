From: John Kacur <jkacur@redhat.com>
Subject: Re: [ANNOUNCE] 3.8.4-rt2
Date: Wed, 17 Apr 2013 18:25:40 +0200
Message-ID: <CAONaPpFSf+Eh3K3BHCsPTQdxmbghHhtH=wMooh+Ers2QiCdH=g@mail.gmail.com>
References: <20130326201722.GA14220@linutronix.de>
	<CAP=VYLoXfECaSBuvYdZ3qbsnR9QMYpoRnKGZdY=P6zS_TYOcCA@mail.gmail.com>
	<20130408183012.GA5778@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:44116 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3DQQZm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Apr 2013 12:25:42 -0400
In-Reply-To: <20130408183012.GA5778@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 8, 2013 at 8:30 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Paul Gortmaker | 2013-04-05 19:35:51 [-0400]:
>
>>Thanks for the work in putting this together.  Just a heads up that the
>>split queue fails on a patch with no author/date/subject as follows:
>>
>>[...]
>>git am of percpu-rwsem-compilefix.patch failed.
>>
>>This "treercu-use-simple-waitqueue.patch" has the exact same problem.
>>
>>Note that I'm using git directly, and not quilt -- which is more
>>strict in what it will accept, hence it catches these kinds of things.
>
> I just fixed up those two. "git quiltimport" works now.
>

Where did you fix these up? Can we have access?

Thanks

John
