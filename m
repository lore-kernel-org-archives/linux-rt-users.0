From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Mon, 24 Sep 2012 10:15:54 +0200
Message-ID: <506016BA.2070704@suse.cz>
References: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com> <20120920171717.04ee9098@bob.linux.org.uk> <CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/24/2012 10:02 AM, Ivo Sieben wrote:
> Hi,
> 
> 2012/9/20 Alan Cox <alan@linux.intel.com>:
>>
>> So now when the user sets tty->low_latency on these devices the machine
>> crashes ?
>>
>> This is the wrong direction - in fact we have a pile we need to move
>> the other way !
>>
>> If they resolve to the same thing in hard RT patches fine, that's a
>> different question.
> 
> Sorry, Allan you are probably right, but I don't get it...
> 
> I agree that when the tty->low_latency flag is set on these machines,
> the drivers that were modified by my patch will behave differently:
> they will call the flush_to_ldisc() function directly instead of using
> the work queue. So that indeed introduces different functionality.
> 
> But what I don't understand is how this would cause the machine to
> crash? Even when the flush_to_ldisc() function is called from hard IRQ
> context this would cause no problems: the flush_to_ldisc() function
> uses IRQ save spin locks instead of mutexes to protect it's critical
> section. Right?

Yes, but there are deadlocks caused when low_latency is set. Simply
because flush_to_ldisc calls tty->ops->flush_chars from ldisc's
receive_buf. And some drivers take a lock there. But they already hold
the lock from the site where they call tty_schedule_flip from.

> Furthermore the majority of TTY drivers currently already use the
> tty_flip_buffer_push() function.

Yes, but not all call tty_flip_buffer_push correctly. If you set
low_latency for them, they explode.

regards,
-- 
js
suse labs
