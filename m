From: Stanislav Meduna <stano@meduna.org>
Subject: Re: paging in realtime context ...
Date: Fri, 28 Jun 2013 17:37:13 +0200
Message-ID: <51CDADA9.1030909@meduna.org>
References: <CAF-VNaov5Y76uhm6W3zPD-oe8xik4ER69Pw8V+dPP8JdJ4gb-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Lars Segerlund <lars.segerlund@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:47011 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740Ab3F1Ph2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jun 2013 11:37:28 -0400
In-Reply-To: <CAF-VNaov5Y76uhm6W3zPD-oe8xik4ER69Pw8V+dPP8JdJ4gb-w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 28.06.2013 16:14, Lars Segerlund wrote:

>  Quick question, if I mlock my app and prefault the stacks, what
> happens if I haven't linked static and use a library ?
> 
>  Surely a bunch of pagefaults ?

I am no kernel expert but as I understand it should not matter
whether the application is linked statically or dynamically.
What is mapped gets locked.

After mlockall returns you should only get pagefaults if the
mapping changes (heap grows, you call mmap, dlopen()
a library, start a new thread, ...).

-- 
                                            Stano

