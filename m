From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.4-rt2
Date: Mon, 8 Apr 2013 20:30:12 +0200
Message-ID: <20130408183012.GA5778@linutronix.de>
References: <20130326201722.GA14220@linutronix.de>
 <CAP=VYLoXfECaSBuvYdZ3qbsnR9QMYpoRnKGZdY=P6zS_TYOcCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39000 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935106Ab3DHSaO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Apr 2013 14:30:14 -0400
Content-Disposition: inline
In-Reply-To: <CAP=VYLoXfECaSBuvYdZ3qbsnR9QMYpoRnKGZdY=P6zS_TYOcCA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-04-05 19:35:51 [-0400]:

>Thanks for the work in putting this together.  Just a heads up that the
>split queue fails on a patch with no author/date/subject as follows:
>
>[...]
>git am of percpu-rwsem-compilefix.patch failed.
>
>This "treercu-use-simple-waitqueue.patch" has the exact same problem.
>
>Note that I'm using git directly, and not quilt -- which is more
>strict in what it will accept, hence it catches these kinds of things.

I just fixed up those two. "git quiltimport" works now.

>Thanks,
>Paul.
>--

Sebastian
