From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Wed, 2 May 2012 14:39:07 +0200
Message-ID: <CAMSQXEG+O86t10AF5gN875RoEHkMcGFQE_-G6TdeYVc4NJoBLw@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
	<CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
	<20120419154609.GA9263@kroah.com>
	<CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
	<CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
	<20120501160456.3b0b5e34@pyramind.ukuu.org.uk>
	<CAMSQXEHAyPOF6YghsYmqqyx+N0oMgn5E=znhgFyspMUnaH78ig@mail.gmail.com>
	<CAMSQXEHHOHeNYPJZT0b4s62T3uuNXSt9WucSrGOTfjXOU_guzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEHHOHeNYPJZT0b4s62T3uuNXSt9WucSrGOTfjXOU_guzg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

> 2012/5/2 Ivo Sieben <meltedpianoman@gmail.com>:
>> Hi,
>>
>> Indeed the lock is only taken for a very short time. So =A0in most
>> situations it works fine, the lock is free, and can be taken quickly=
=2E
>> But when I stress my system (e.g. by continuously dumpling a lot of
>> text data to another serial terminal from the background), my high
>> priority task sometimes finds the lock is taken. In that case
>> additional lock handling comes in: priority inheritance, a context
>> switch to the background task that holds the lock, and a context
>> switch back after the lock is released again. This makes a normal re=
ad
>> that takes about 50us, to increase in execution time to 150us.

The PREEMPT_RT uses mutexes for "normal" spin locks that do not
disable interrupts...
I'll try to use raw spinlocks in this code section and for the tty flip=
 buffer
See if that can solve my problem.

If you have other ideas... let me know!

Regards,
Ivo
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
