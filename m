From: David Sommerseth <davids@redhat.com>
Subject: Re: [PATCH] hackbench: init child's struct before using it
Date: Thu, 11 Apr 2013 20:11:04 +0200
Message-ID: <5166FCB8.2020402@redhat.com>
References: <1365693605-22704-1-git-send-email-bigeasy@linutronix.de> <20130411120800.06d750b2@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964882Ab3DKSLA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Apr 2013 14:11:00 -0400
In-Reply-To: <20130411120800.06d750b2@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/13 19:08, Clark Williams wrote:
> Applied to my work branch for the next release. I've CC'd John
> Kacur who has been doing the heavy lifting on rt-tests recently.

Oh look at that ... I thought this patch looked familiar ... seems I
fixed this in October 2010 but that patch probably fell through some
cracks somewhere.  Well, Sebastian sure gets the glory on this one :)

But full ACK on this patch from me as well.


David S.



> On Thu, 11 Apr 2013 17:20:05 +0200 Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> 
>> Commit ad27df7 ("Reimplement better child tracking and improve
>> error handling") changed the way of reporting pid/error after
>> creating a child. It will return an union which is a mix pid_t,
>> pthread_t and a signed long long for errors. Now on 32bit x86
>> both pid_t and pthread_t are four byte in size and are stored in
>> the first 4 bytes. Now if the most significant bit of the long 
>> long variable happens to be set by chance (because nobody really 
>> initializes the variable here) then error variable will be
>> negative. On little endian machines the assignment of pid or
>> threadid won't reset the sign bit and you see this:
>> 
>> | Running in process mode with 10 groups using 40 file
>> descriptors each (== 400 tasks) | Each sender will pass 100
>> messages of 100 bytes | 0 children started.  Expected 40 |
>> sending SIGTERM to all child processes | signaling 0 worker
>> threads to terminate | Creating workers (error: Success)
>> 
>> A machine with proper endian handlig (that is big endian) would
>> reset the sign bit during the assignment of pid and I would not
>> have to make this patch :)
>> 
>> While here, I make create_worker() since it is not used outside
>> of this file.
>> 
>> Cc: David Sommerseth <davids@redhat.com> Signed-off-by: Sebastian
>> Andrzej Siewior <bigeasy@linutronix.de> --- 
>> src/hackbench/hackbench.c |    3 ++- 1 file changed, 2
>> insertions(+), 1 deletion(-)
>> 
>> diff --git a/src/hackbench/hackbench.c
>> b/src/hackbench/hackbench.c index 8baeb23..c21b4db 100644 ---
>> a/src/hackbench/hackbench.c +++ b/src/hackbench/hackbench.c @@
>> -189,13 +189,14 @@ static void *receiver(struct receiver_context*
>> ctx) return NULL; }
>> 
>> -childinfo_t create_worker(void *ctx, void *(*func)(void *)) 
>> +static childinfo_t create_worker(void *ctx, void *(*func)(void
>> *)) { pthread_attr_t attr; int err; childinfo_t child; pid_t
>> childpid;
>> 
>> +	memset(&child, 0, sizeof(child)); switch (process_mode) { case
>> PROCESS_MODE: /* process mode */ /* Fork the sender/receiver
>> child. */ -- 1.7.10.4
>> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFm/LMACgkQIIWEatLf4HcwMACeOJWBvqmCgqTIwGxpZNen73qP
ttkAoLBlPfMsF9c37hQWZQluNBlfEDpr
=9hkd
-----END PGP SIGNATURE-----
