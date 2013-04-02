From: Stanislav Meduna <stano-eBkVDd3zSwodnm+yROfE0A@public.gmane.org>
Subject: malloc/free and priority inheritance?
Date: Wed, 03 Apr 2013 01:06:36 +0200
Message-ID: <515B647C.3080505@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: libc-help-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org
Return-path: <libc-help-return-2602-gclgu-libc-help=m.gmane.org-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org>
List-Unsubscribe: <mailto:libc-help-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:libc-help-subscribe-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org>
List-Post: <mailto:libc-help-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org>
List-Help: <mailto:libc-help-help-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org>, <http://sourceware.org/lists.html#faqs>
Sender: libc-help-owner-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I am hunting a possible priority inversion case and I would like
to ask whether the malloc/free from glibc (particularly 2.11.3
used in Debian 6 or newer) uses priority inheritance mutexes
when doing the necessary locking.

There is http://sourceware.org/bugzilla/show_bug.cgi?id=12114
which would suggest that it is not - is this (still) true?
If yes, is there some patch or are there tried&tested alternative
malloc libraries that do not have the problem (e.g. tcmalloc)?
I am using it on a RT_PREEMPT_FULL linux-rt.

Please Cc me on answer, I am not subscribed to libc-help

Thanks
-- 
                                        Stano
