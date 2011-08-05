From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Fri, 05 Aug 2011 09:03:03 -0700
Message-ID: <4E3C1437.7030301@ccrma.stanford.edu>
References: <alpine.LFD.2.02.1107282213000.31246@ionos> <4E3A3D7C.6050403@localhost> <1312450965.16729.7.camel@twins> <4E3AED68.5060506@ccrma.stanford.edu> <20110804201500.GL31521@pengutronix.de> <20110805092845.GP31521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110805092845.GP31521@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/05/2011 02:28 AM, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 04, 2011 at 10:15:00PM +0200, Uwe Kleine-K=F6nig wrote:
>> On Thu, Aug 04, 2011 at 12:05:12PM -0700, Fernando Lopez-Lezcano wro=
te:
>>> Was going to try this but it appears it is in rt7, trying to build
>>> rt7 fails with:
>>>
>>> ERROR: "of_find_property" [drivers/tty/serial/of_serial.ko] undefin=
ed!
>>> ERROR: "of_find_property" [drivers/hwmon/ltc4245.ko] undefined!
>> This is known but unfixed, see
>> http://mid.gmane.org/20110722065711.GD16561@pengutronix.de
>>
>> You should be able to workaround that by jugling with the .config. I=
=2Ee.
>> disable OF or something like that.
> Can you send me a .config, then I'd look into that.

To work around the issue I had to disable:

   CONFIG_SERIAL_OF_PLATFORM
   CONFIG_SENSORS_LTC4245

-- Fernando
