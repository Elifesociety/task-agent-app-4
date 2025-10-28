-- Add priority field to programs table if not exists
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'programs' AND column_name = 'priority'
  ) THEN
    ALTER TABLE public.programs ADD COLUMN priority INTEGER DEFAULT 0;
  END IF;
END $$;

-- Create index for better performance when querying top programs
CREATE INDEX IF NOT EXISTS idx_programs_is_top_priority ON public.programs(is_top DESC, priority DESC);