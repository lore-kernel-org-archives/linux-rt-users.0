From: Michal Schmidt <mschmidt@redhat.com>
Subject: Re: updated ketchup script
Date: Tue, 27 Nov 2007 12:16:56 +0100
Message-ID: <20071127121656.1058043c@brian.englab.brq.redhat.com>
References: <20071122154127.0775192e@brian.englab.brq.redhat.com>
	<Pine.LNX.4.58.0711261656560.7707@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbXK0LRI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Nov 2007 06:17:08 -0500
In-Reply-To: <Pine.LNX.4.58.0711261656560.7707@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 26 Nov 2007 16:57:32 -0500 (EST)
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Thu, 22 Nov 2007, Michal Schmidt wrote:
> 
> > Steven,
> >
> > Your ketchup script does not download the -rt kernel for me. This
> > patch fixes it. Could you update
> > http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt1 ?
> >
> > I'm also attaching the complete ketchup script for convenience.
> >
> 
> Michal,
> 
> Could you explain what exactly went wrong.  Your ketchup script
> doesn't work for me. It fails downloads for me.

Trying to find the latest version with your ketchup version:

$ ketchup-0.9.8-rt1 -s 2.6-rt
?C=N;O=D">Name</a>                                         <a
href="?C=M;O=A">Last modified</a>      <a href="?C=S;O=A">Size</a>
<hr><a href="/pub/linux/kernel/projects/rt

Not surprisingly, trying to update also fails:

$ ketchup-0.9.8-rt1 2.6-rt
2.6.24-rc2-rt1
-> ?C=N;O=D">Name</a>                                         <a
href="?C=M;O=A">Last modified</a>      <a href="?C=S;O=A">Size</a>
<hr><a href="/pub/linux/kernel/projects/rt
Traceback (most recent call last):
  File "/home/mschmidt/bin/ketchup-0.9.8-rt1", line 755, in ?
    transform(a, b)
  File "/home/mschmidt/bin/ketchup-0.9.8-rt1", line 516, in transform
    if t != tree(b):
  File "/home/mschmidt/bin/ketchup-0.9.8-rt1", line 109, in tree
    return float(re.match(r'(\d+\.\d+)', ver).group(1))
AttributeError: 'NoneType' object has no attribute 'group'


Do you use a non-default kernel_url in your ketchup configuration?

Michal
