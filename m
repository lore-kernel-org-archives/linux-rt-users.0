From: Pedro Ribeiro <pedrib@gmail.com>
Subject: modification of tp-smapi module for -rt
Date: Sat, 13 Feb 2010 21:11:33 +0000
Message-ID: <74fd948d1002131311q68f7e2e2s399f31e95de8d179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:59976 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901Ab0BMVLf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Feb 2010 16:11:35 -0500
Received: by ewy28 with SMTP id 28so2886521ewy.28
        for <linux-rt-users@vger.kernel.org>; Sat, 13 Feb 2010 13:11:33 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I use an out of tree module called tp-smapi, which is basically an
advanced battery control module for thinkpads.
This module uses a couple of mutexes which I had to modify for it to
build with the latest .31.12-rt20.

However, I'm clueless about this, so basically what I did was look at
the rt patch for similar sections and change it in the tp-smapi
source.

Can anyone please have a look at what I've done and tell me if its
correct or not? The module appears to work correctly but you never
know.

I replaced a
static DECLARE_MUTEX(thinkpad_ec_mutex);
with a
static DEFINE_SEMAPHORE(thinkpad_ec_mutex);

This is called in
-----------------------------------------------------------------------------
/**
 * thinkpad_ec_lock - get lock on the ThinkPad EC
 *
 * Get exclusive lock for accesing the ThinkPad embedded controller LPC3
 * interface. Returns 0 iff lock acquired.
 */
int thinkpad_ec_lock(void)
{
	int ret;
	ret = down_interruptible(&thinkpad_ec_mutex);
	return ret;
}
EXPORT_SYMBOL_GPL(thinkpad_ec_lock);

/**
 * thinkpad_ec_try_lock - try getting lock on the ThinkPad EC
 *
 * Try getting an exclusive lock for accesing the ThinkPad embedded
 * controller LPC3. Returns immediately if lock is not available; neither
 * blocks nor sleeps. Returns 0 iff lock acquired .
 */
int thinkpad_ec_try_lock(void)
{
	return down_trylock(&thinkpad_ec_mutex);
}
EXPORT_SYMBOL_GPL(thinkpad_ec_try_lock);

/**
 * thinkpad_ec_unlock - release lock on ThinkPad EC
 *
 * Release a previously acquired exclusive lock on the ThinkPad ebmedded
 * controller LPC3 interface.
 */
void thinkpad_ec_unlock(void)
{
	up(&thinkpad_ec_mutex);
}
EXPORT_SYMBOL_GPL(thinkpad_ec_unlock);
------------------------------------------------------------------

Then I replaced a
static DECLARE_MUTEX(smapi_mutex);
with a
static DEFINE_MUTEX(smapi_mutex);

which is called in various other code sections with
down(&smapi_mutex);
and
up(&smapi_mutex);


Please let me know if this is enough, or if you need to look into the code!

Your help is much appreciated.

Regards,
Pedro
