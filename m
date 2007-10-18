From: "Javier Sanz" <jsanza@gmail.com>
Subject: Re: [PATCH 8/9] RT: Fixes for push-rt patch
Date: Thu, 18 Oct 2007 13:00:03 +0200
Message-ID: <a3d4028e0710180400q2d82d672xf9f4d738fe41d272@mail.gmail.com>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net>
	 <20071017185108.11272.42107.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:47123 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154AbXJRLAE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 07:00:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so146279wah
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 04:00:03 -0700 (PDT)
In-Reply-To: <20071017185108.11272.42107.stgit@novell1.haskins.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I am newbie in rt programming  and i wonder where can i get an example
about file handling following the describe idea from rt wiki
" File handling .-
File handling is known to generate disastrous pagefaults. So, if there
is a need for file access from the context of the RT-application, then
this can be done best by splitting the application in an RT part and a
file-handling part. Both parts are allowed to communicate through
sockets. I have never seen a page fault caused by socket traffic.
Note: While accessing files the low-level fopen() call will do a
mmap() to allocate new memory to the process, resulting in a new
pagefault."

any sample with rt part and file handle part ?

Another question, about  java realtime specification , rtsj

i wonder, if rt programming (using c) needs to check a lot of elements
, faultpages, sockets, etc ... how can it possible that a java
programmer can run applications (with a gc collector) and these
applications can get a "rt profile" ?

rtsj is a "valuable" real time specificacion?

thank you
