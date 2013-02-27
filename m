From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Wed, 27 Feb 2013 18:25:59 +0200
Message-ID: <CA+69FtAtp6N97oOBucpAWP1XeiavHbPQBcKJJMXQOuR5fh+TDQ@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
	<20130227100957.22994960@riff.lan>
	<CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:51767 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3B0Q0A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 11:26:00 -0500
Received: by mail-ve0-f175.google.com with SMTP id cy12so758531veb.20
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Feb 2013 08:25:59 -0800 (PST)
In-Reply-To: <CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 27, 2013 at 6:22 PM, Hartmut Behrens
<hartmut.behrens@gmail.com> wrote:
>> What happens if you compile and run this program on your kernel?
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sched.h>
>> #include <errno.h>
>> #include <memory.h>
>>
>> int main(int argc, char **argv)
>> {
>>         int ret;
>>         struct sched_param s;
>>
>>         memset(&s, 0, sizeof(s));
>>         s.sched_priority = 1;
>>         if ((sched_setscheduler(0, SCHED_FIFO, &s))) {
>>                 fprintf(stderr, "error changing policy: %s\n", strerror(errno));
>>                 exit(errno);
>>         }
>>         printf("successfully changed policy to SCHED_FIFO priority 1\n");
>>         exit(0);
>> }
>
> When I run it as root I get "error changing policy: Operation not permitted".
>
> Does this mean that some hard limits are not correctly set for root?

Could a fix be to switch off CONFIG_RT_GROUP_SCHED ?
(http://www.kernel.org/doc/Documentation/scheduler/sched-rt-group.txt)
