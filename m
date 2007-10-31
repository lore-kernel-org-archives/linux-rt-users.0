From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Is it a stupid question?
Date: Wed, 31 Oct 2007 09:12:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710310907080.14427@gandalf.stny.rr.com>
References: <1193815771.5037.1.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:33833 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbXJaNNA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 09:13:00 -0400
In-Reply-To: <1193815771.5037.1.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--
On Wed, 31 Oct 2007, Alessio Igor Bogani wrote:

> Hi All,
>
> Normally i use, like many others, the file patch-2.6.X.Y-rtZ for
> patching the kernel.
>
> But in case i would want use the broken-out version ...
> What is the right order to apply all patches contained in
> patch-2.6.X.Y-rtZ-broken-out.tar.bz2 ?
>
> Please excuse me if it is a stupid question!

Not at all.


Note, 2.6.23.1-rt4 broken out was more broken than out. I forgot to
refresh the queue, and one of the patches would not apply.

So for 2.6.23.1-rt5, you need to first install 2.6.23.1 and then untar the
patch queue in that directory.  Use quilt to do a "quilt push -a" to get
to the -rt version.

So the "-rtX" part is what the patches do. Everything before that is up to
you. So currently we apply to 2.6.23.1.

I also use my version of ketchup to get to the kernel (for the big patch).

wget -O ketchup http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt1

And then it is as easy as...

$ mkdir tmp
$ cd tmp
$ ketchup -r -G 2.6.23.1-rt5
$ cd .

and you are all set ;-)

-- Steve
