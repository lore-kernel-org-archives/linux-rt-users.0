From: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 4 Apr 2013 21:02:27 +0530
Message-ID: <CAAHN_R2zdvYwQL_Md8C=+O9w3tc2y+XR5tofv3FEe6CjcOubAQ@mail.gmail.com>
References: <515B647C.3080505@meduna.org>
	<515D7943.5000401@meduna.org>
	<515D808C.8090808@meduna.org>
	<CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
	<515D93F8.5050006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stanislav Meduna <stano@meduna.org>,
	libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Carlos O'Donell" <carlos@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:49307 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762713Ab3DDPc3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 11:32:29 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so2137059wea.24
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2013 08:32:28 -0700 (PDT)
In-Reply-To: <515D93F8.5050006@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 4 April 2013 20:23, Carlos O'Donell <carlos@redhat.com> wrote:
> ... and ARM uses the generic C code.
>
> My comments in BZ#12114 still remain. Why can't we make malloc/free
> use PI locks? We need not convert lll_lock, but just make malloc-machine.h
> use a PI-aware lock?

The trouble (as always) is to decide on when to use PI-aware locks.
Do we do that by default or do we have (*chuckle*) an environment
variable to override the default locks?  Maybe this discussion is more
suitable for libc-alpha though, since we can hopefully get all
maintainers to chime in there.

Siddhesh
--
http://siddhesh.in
