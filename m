From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Wed, 27 Feb 2013 08:26:45 +0200
Message-ID: <CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:57003 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3B0G0q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 01:26:46 -0500
Received: by mail-vc0-f176.google.com with SMTP id fk10so145026vcb.7
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Feb 2013 22:26:45 -0800 (PST)
In-Reply-To: <20130225152122.49c408ec@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 25, 2013 at 11:21 PM, Clark Williams <williams@redhat.com> wrote:
> Changing your scheduling policy requires extra privileges. You can
> either run cyclictest as root, or if your distribution uses PAM, you
> can set up a file in /etc/security/limits.d which enable group access to
> changing scheduler policy. You can name the file whatever you want, I
> usually call mine 99-realtime.conf:
>
> # cat <<EOF >/etc/security/limits.d/99-realtime.conf
> @realtime       -       rtprio  99
> @realtime       -       memlock unlimited
> EOF
>
> Then create a group named realtime and add your username to the newly
> created group:
>
> # groupadd realtime
> # usermod -a -G realtime yourUserID
>
> Log out, then log back in and you should be able to verift that you're
> in the realtime group using the 'groups' command. Once you're username
> is a member of the realtime group, you should be able to run cyclictest
> without being root.

This problem persists even when I run cyclictest as root. I have also
set up PAM as described above and added root to the realtime group
without any success.
I have also tried "sudo ./cyclictest" and " su -c './cyclictest'

Is this perhaps a more fundamental problem?

Just to recap: I applied the patch-3.2-rt10 patch cleanly to a v3.2
kernel customized for a TI OMAP (ARM) processor. CONFIG_PREEMPT_RT was
enabled and CPU frequency scaling disabled.

HB
