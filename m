From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Wed, 27 Feb 2013 18:22:20 +0200
Message-ID: <CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
	<20130227100957.22994960@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:52270 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3B0QWV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 11:22:21 -0500
Received: by mail-ve0-f170.google.com with SMTP id 14so767869vea.15
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Feb 2013 08:22:21 -0800 (PST)
In-Reply-To: <20130227100957.22994960@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 27, 2013 at 6:09 PM, Clark Williams <williams@redhat.com> wrote:
> What happens if you compile and run this program on your kernel?
> #include <stdio.h>
> #include <stdlib.h>
> #include <sched.h>
> #include <errno.h>
> #include <memory.h>
>
> int main(int argc, char **argv)
> {
>         int ret;
>         struct sched_param s;
>
>         memset(&s, 0, sizeof(s));
>         s.sched_priority = 1;
>         if ((sched_setscheduler(0, SCHED_FIFO, &s))) {
>                 fprintf(stderr, "error changing policy: %s\n", strerror(errno));
>                 exit(errno);
>         }
>         printf("successfully changed policy to SCHED_FIFO priority 1\n");
>         exit(0);
> }

When I run it as root I get "error changing policy: Operation not permitted".

Does this mean that some hard limits are not correctly set for root?
