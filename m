From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Thu, 28 Feb 2013 17:07:06 +0200
Message-ID: <CA+69FtBGT0NJ5Yh1Qqc9YWh+PuM_p=dng8=ApK1ie4ia0QvPiA@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
	<20130227100957.22994960@riff.lan>
	<CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
	<20130227140013.0f28c91b@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:39030 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849Ab3B1PHH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Feb 2013 10:07:07 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz10so1921178veb.32
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Feb 2013 07:07:06 -0800 (PST)
In-Reply-To: <20130227140013.0f28c91b@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 27, 2013 at 10:00 PM, Clark Williams <williams@redhat.com> wrote:
> Well this is a new one on me. Some questions:
>
> Do you have SELinux running?

No SELinux is disabled

>
> Are there any files in /etc/security/limits.d other than the one you put
> there?
>
Yes there are:

root@overo:/etc/security# ls -l
total 40
-rw-r--r-- 1 root root 4620 Feb 26  2013 access.conf
-rw-r--r-- 1 root root 3635 Feb 26  2013 group.conf
-rw-r--r-- 1 root root 1825 Feb 26  2013 limits.conf
drwxr-xr-x 2 root root 4096 Feb 26  2013 limits.d
-rw-r--r-- 1 root root 1442 Feb 26  2013 namespace.conf
drwxr-xr-x 2 root root 4096 Feb 26  2013 namespace.d
-rwxr-xr-x 1 root root 1020 Feb 26  2013 namespace.init
-rw-r--r-- 1 root root 2980 Feb 26  2013 pam_env.conf
-rw-r--r-- 1 root root 2180 Feb 26  2013 time.conf


> Other than that I can't think of a reason why sched_setscheduler()
> would fail as root.
