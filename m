From: John Kacur <jkacur@redhat.com>
Subject: Re: tracefs .. idea
Date: Tue, 16 Oct 2012 13:04:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210161301460.3137@tycho>
References: <CAF-VNaq+CpDLzLXVg2o2KAZ7fyQfhvxAs6wRWrgvHh3jJ9+2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54417 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab2JPLCZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 07:02:25 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2911690bkc.19
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Oct 2012 04:02:23 -0700 (PDT)
In-Reply-To: <CAF-VNaq+CpDLzLXVg2o2KAZ7fyQfhvxAs6wRWrgvHh3jJ9+2fQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 16 Oct 2012, Lars Segerlund wrote:

>  I was thinking of tracking locks and above all interrupt disable
> through debugfs.
> 
>  Something along the lines of a buffer with the top offenders in it,
> and thus getting a list of the longest latency introducing sections.
>  Or would it be 'better' to instrument with something like kprobes and
> have a utility for this functionality ?
> 
>  Any further idea of stuff to trace ? or has this already been done
> and I am unaware of it ?
> 
>  I basicly want a list of the sections in the kernel that disables
> preemption for the longest time.

Hi Lars - Have a look at ftrace, I think it does what you are looking for.
In the kernel source read, Documentation/trace/ftrace.txt
Look at "preemptoff" to see how to record the amount of time preemption is 
disabled.

John
