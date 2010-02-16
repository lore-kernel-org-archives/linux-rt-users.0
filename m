From: Robin Gareus <robin@gareus.org>
Subject: Re: modification of tp-smapi module for -rt
Date: Tue, 16 Feb 2010 02:34:09 +0100
Message-ID: <4B79F611.6010806@gareus.org>
References: <74fd948d1002131311q68f7e2e2s399f31e95de8d179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:15132 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443Ab0BPBeO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Feb 2010 20:34:14 -0500
In-Reply-To: <74fd948d1002131311q68f7e2e2s399f31e95de8d179@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pedro Ribeiro wrote:
> Hi all,
> 
> I use an out of tree module called tp-smapi, which is basically an
> advanced battery control module for thinkpads.
> This module uses a couple of mutexes which I had to modify for it to
> build with the latest .31.12-rt20.
> 
> However, I'm clueless about this, so basically what I did was look at
> the rt patch for similar sections and change it in the tp-smapi
> source.
> 
> Can anyone please have a look at what I've done and tell me if its
> correct or not? The module appears to work correctly but you never
> know.
> 
> I replaced a
> static DECLARE_MUTEX(thinkpad_ec_mutex);
> with a
> static DEFINE_SEMAPHORE(thinkpad_ec_mutex);
> 
> This is called in
> -----------------------------------------------------------------------------
> /**
>  * thinkpad_ec_lock - get lock on the ThinkPad EC
>  *
>  * Get exclusive lock for accesing the ThinkPad embedded controller LPC3
>  * interface. Returns 0 iff lock acquired.
>  */
> int thinkpad_ec_lock(void)
> {
> 	int ret;
> 	ret = down_interruptible(&thinkpad_ec_mutex);
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(thinkpad_ec_lock);
> 
> /**
>  * thinkpad_ec_try_lock - try getting lock on the ThinkPad EC
>  *
>  * Try getting an exclusive lock for accesing the ThinkPad embedded
>  * controller LPC3. Returns immediately if lock is not available; neither
>  * blocks nor sleeps. Returns 0 iff lock acquired .
>  */
> int thinkpad_ec_try_lock(void)
> {
> 	return down_trylock(&thinkpad_ec_mutex);
> }
> EXPORT_SYMBOL_GPL(thinkpad_ec_try_lock);
> 
> /**
>  * thinkpad_ec_unlock - release lock on ThinkPad EC
>  *
>  * Release a previously acquired exclusive lock on the ThinkPad ebmedded
>  * controller LPC3 interface.
>  */
> void thinkpad_ec_unlock(void)
> {
> 	up(&thinkpad_ec_mutex);
> }
> EXPORT_SYMBOL_GPL(thinkpad_ec_unlock);
> ------------------------------------------------------------------
> 
> Then I replaced a
> static DECLARE_MUTEX(smapi_mutex);
> with a
> static DEFINE_MUTEX(smapi_mutex);
> 
> which is called in various other code sections with
> down(&smapi_mutex);
> and
> up(&smapi_mutex);
> 
> 
> Please let me know if this is enough, or if you need to look into the code!

Looks good to me.

> Your help is much appreciated.

I basically did the same a few months ago:
http://rg42.org/blog/thinkpad_smapi_and_realtime_linux

I chose to change
- -static DECLARE_MUTEX(thinkpad_ec_mutex);
+static struct mutex thinkpad_ec_mutex;

and replaced down_interruptible(), down_trylock(), up() and down() with
mutex_lock_killable(), mutex_trylock(), mutex_unlock() and mutex_lock()
respectively; plus adding a mutex_init() call.

Here's a direct link to the diff:
http://rg42.org/_media/blog/tpsmapi/tp_smapi-rt.diff

Your solution is less intrusive but also less compatible. The
mutex_..() functions work with both -rt and vanilla kernels.

Cheers!
robin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkt59hEACgkQeVUk8U+VK0IxkQCeM4TIhrypHz4yED5wWRnN5J/G
AHcAn0LqL/vnh82STtrPDSxLYll5MIia
=KJJY
-----END PGP SIGNATURE-----
