From: "Javier Sanz" <jsanza@gmail.com>
Subject: file handling sample and java rtsj question
Date: Thu, 18 Oct 2007 13:43:30 +0200
Message-ID: <a3d4028e0710180443x79b9a752pe26143b6d29171b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:4496 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbXJRLnb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 07:43:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so157303wah
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 04:43:30 -0700 (PDT)
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

Another question, about  java realtime specification, java sun rtsj

I wonder, if rt programming (using c) needs to check a lot of elements
, faultpages, sockets, etc ... how can it possible that a java
programmer can run applications (with a gc collector) and these
applications can get a "rt profile" ?

 is  RTSJ a "valid" real time specification?

thank you
