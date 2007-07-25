From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 17:28:00 +0200
Message-ID: <200707251728.00207.fzu@wemgehoertderstaat.de>
References: <469600F7.3060603@free.fr> <20070725133835.GA17616@elte.hu> <46A758B5.9070602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932593AbXGYP1T@vger.kernel.org>
In-Reply-To: <46A758B5.9070602@free.fr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Am Mittwoch, 25. Juli 2007 schrieb John Sigler:
> 
> Is there some form of priority inheritance? Does the IRQ handler get a 
> priority boost if a high priority task is waiting for it?

No. But that would be "nice to have".

      Karsten
