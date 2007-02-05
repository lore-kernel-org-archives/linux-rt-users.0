From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 15:25:49 +0100
Message-ID: <200702051525.49465.fzu@wemgehoertderstaat.de>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932854AbXBEOZy@vger.kernel.org>
In-Reply-To: <20070205065636.GA1652@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Am Montag, 5. Februar 2007 07:56 schrieb Ingo Molnar:
> i have released the v2.6.20-rt1 kernel, which can be downloaded from the 

after resuming from
	$ echo mem > /sys/power/state
both lapic and pic are active, while only lapic should be.
resuming from
	$ echo disk > /sys/power/state
is fine.

      Karsten
