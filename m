From: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 4 Apr 2013 21:09:57 +0530
Message-ID: <CAAHN_R0oHL+oWxs_0SBwi4dRWM9HDrFM0Y7ZDLZQGNHnnxYzHQ@mail.gmail.com>
References: <515B647C.3080505@meduna.org>
	<515D7943.5000401@meduna.org>
	<515D808C.8090808@meduna.org>
	<CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
	<515D97B8.5030101@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:53480 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760168Ab3DDPj6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 11:39:58 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so2781382wgh.34
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2013 08:39:57 -0700 (PDT)
In-Reply-To: <515D97B8.5030101@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 4 April 2013 20:39, Stanislav Meduna <stano@meduna.org> wrote:
> The first thing e.g. the __pthread_cond_broadcast (and most of the
> other functions as well) does is to grab lll_lock. Is the following
> scenario possible?

Yes this is possible.  I think there is a bug report that describes
this.  We need to convert the pthread_cond_t internal lock into a PI
one if the mutex guarding it is PI.  It's probably tricky to do
though; I haven't thought it through.

Siddhesh
--
http://siddhesh.in
