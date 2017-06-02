From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: cyclictest usage
Date: Fri, 2 Jun 2017 09:54:16 -0700
Message-ID: <CANGgnMayznQDLuR++ZoQVVJfTCK-tjRk1-HLakSdsQU7eb7EGg@mail.gmail.com>
References: <20170526112502.4f6a49ac@tagon> <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
 <20170602092612.4069fe8f@tagon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35526 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdFBQyi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 12:54:38 -0400
Received: by mail-vk0-f42.google.com with SMTP id w1so43094707vkd.2
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Jun 2017 09:54:37 -0700 (PDT)
In-Reply-To: <20170602092612.4069fe8f@tagon.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 2, 2017 at 7:26 AM, Clark Williams <williams@redhat.com> wrote:
> Regarding periodic updates, what do you think about providing a way for a=
n app to query the current state of a run? Possibly a memory region that ca=
n be mmapped by a process? Or possibly a UNIX domain socket? I'm thinking o=
f the case where you're doing a 48 hour test run on a box where you don't h=
ave easy access to the console and would just like to know if a) the box is=
 alive and b) is still showing reasonable values for max latency and jitter=
.
>
> I kinda like the memory region since that's how cyclictest handles output=
: the measurement threads all dump their data into a cpu-specific memory ar=
ea and a display thread (running at a low priority) is the one that wakes u=
p, reads the update and printf's to the screen. If we exported that region =
so that another process could mmap it read-only, that would provide a way t=
o get a snapshot of the run, without actually depending on cyclictest to *d=
o* anything out of the ordinary.

I might be missing something, but if you want to be able to view the
status remotely, why not tee the output to a file and tail that from
the remote session, or use screen/tmux/etc?  That would stay aligned
with Sebastian's goal of keeping it small and simple.

> Thanks for the input Sebastian.
>
> Clark

Austin
