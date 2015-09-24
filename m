From: John Kacur <jkacur@redhat.com>
Subject: Re: Is it possible to change Makefile to CMake
Date: Thu, 24 Sep 2015 23:17:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509242306120.7378@riemann>
References: <CAAocCaLoe90YNajEy5ecxciTfu_BR7NLRk43gF2YAj_FwKYFsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: yuanbin zhou <hduffddybz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35223 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbbIXVRp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2015 17:17:45 -0400
Received: by wicge5 with SMTP id ge5so1336371wic.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2015 14:17:42 -0700 (PDT)
In-Reply-To: <CAAocCaLoe90YNajEy5ecxciTfu_BR7NLRk43gF2YAj_FwKYFsg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 24 Sep 2015, yuanbin zhou wrote:

> Hi,williams,jkacur
>     Is it possible to change the build tool Makefile to CMake, since the
> Makefile is so hard to read and write,instead CMake is a more efficient
> tool to build project.Although rt-test is not a big complicated project,I
> think it will bring more convernient.Can give me some advice to do this
> work?
> 

Probably not. The thing about traditional makefiles, including with all 
the GNU extensions, is that they are well understood by most of the people 
programming in the Linux world. They are well understood by the 
maintainers of this project, and by most of the users and contributers to 
the rt-tests project. Is there something you need to do, that you are 
being held back by because of our make system that I can help you with?

Now, this is of course open source, so you're welcome to hack away at it. 
If you come to me with a new make system that solves some problems that we 
are having, then I might be persuaded, but I bet there are more useful 
things you could be doing with your time - including time used to hack on 
parts of this project.

For most people, the make system works well enough. As you say, it isn't a 
huge project, so we're trying to avoid big hammer solutions. That being 
said, some folks are trying to persuade me that Autotools might be able to solve some 
of the problems we have. Perhaps in the future if we are trying to add a 
lot of odd architectures, it might be worthwhile for us to try something 
like Autotools - and worthwhile for me to bite the bullet and learn it 
well enough.

So for now, no, it might be more convenient for you, if you know CMake 
better, but it won't be more convenient for me, and most 
contributers / users, so just a query out of the blue like that, of course not.

John
