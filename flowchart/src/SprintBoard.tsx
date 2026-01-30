import { useState, useCallback, DragEvent } from 'react';

export interface SprintCard {
  id: string;
  title: string;
  description: string;
  progress: number;
  acceptanceCriteria: string[];
  branchName?: string;
}

export type ColumnId = 'backlog' | 'in-progress' | 'ready-for-ralph' | 'done';

interface Column {
  id: ColumnId;
  title: string;
  color: string;
}

const columns: Column[] = [
  { id: 'backlog', title: 'Backlog', color: '#e2e8f0' },
  { id: 'in-progress', title: 'In Progress', color: '#fef3c7' },
  { id: 'ready-for-ralph', title: 'Ready for Ralph', color: '#dbeafe' },
  { id: 'done', title: 'Done', color: '#d1fae5' },
];

interface CardsByColumn {
  'backlog': SprintCard[];
  'in-progress': SprintCard[];
  'ready-for-ralph': SprintCard[];
  'done': SprintCard[];
}

const initialCards: CardsByColumn = {
  'backlog': [
    {
      id: 'card-1',
      title: 'Add user authentication',
      description: 'Implement login/logout functionality',
      progress: 0,
      acceptanceCriteria: ['Login form works', 'Logout clears session', 'Typecheck passes'],
      branchName: 'feature/auth',
    },
    {
      id: 'card-2',
      title: 'Create dashboard layout',
      description: 'Design the main dashboard structure',
      progress: 0,
      acceptanceCriteria: ['Layout is responsive', 'Navigation works', 'Typecheck passes'],
      branchName: 'feature/dashboard',
    },
  ],
  'in-progress': [
    {
      id: 'card-3',
      title: 'Fix drag-drop functionality',
      description: 'Enable dragging cards between columns',
      progress: 50,
      acceptanceCriteria: ['Drag works', 'Drop works', 'Visual feedback', 'Typecheck passes'],
      branchName: 'fix/drag-drop',
    },
  ],
  'ready-for-ralph': [
    {
      id: 'card-4',
      title: 'Write unit tests',
      description: 'Add tests for core components',
      progress: 80,
      acceptanceCriteria: ['Coverage > 80%', 'All tests pass', 'Typecheck passes'],
      branchName: 'test/unit-tests',
    },
  ],
  'done': [
    {
      id: 'card-5',
      title: 'Set up project structure',
      description: 'Initialize React app with TypeScript',
      progress: 100,
      acceptanceCriteria: ['Vite configured', 'TypeScript working', 'Lint passes'],
      branchName: 'setup/initial',
    },
  ],
};

interface EditModalProps {
  card: SprintCard;
  onSave: (card: SprintCard) => void;
  onClose: () => void;
}

function EditModal({ card, onSave, onClose }: EditModalProps) {
  const [editedCard, setEditedCard] = useState<SprintCard>({ ...card });

  const handleProgressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = parseInt(e.target.value, 10);
    setEditedCard({ ...editedCard, progress: Math.max(0, Math.min(100, value)) });
  };

  const handleSave = () => {
    onSave(editedCard);
    onClose();
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <h2>Edit Card</h2>
        <div className="modal-field">
          <label>Title</label>
          <input
            type="text"
            value={editedCard.title}
            onChange={(e) => setEditedCard({ ...editedCard, title: e.target.value })}
          />
        </div>
        <div className="modal-field">
          <label>Description</label>
          <textarea
            value={editedCard.description}
            onChange={(e) => setEditedCard({ ...editedCard, description: e.target.value })}
          />
        </div>
        <div className="modal-field">
          <label>Progress (%)</label>
          <input
            type="number"
            min="0"
            max="100"
            value={editedCard.progress}
            onChange={handleProgressChange}
          />
        </div>
        <div className="modal-actions">
          <button onClick={onClose} className="cancel-btn">Cancel</button>
          <button onClick={handleSave} className="save-btn">Save</button>
        </div>
      </div>
    </div>
  );
}

export default function SprintBoard() {
  const [cards, setCards] = useState<CardsByColumn>(initialCards);
  const [draggedCard, setDraggedCard] = useState<SprintCard | null>(null);
  const [draggedFromColumn, setDraggedFromColumn] = useState<ColumnId | null>(null);
  const [dragOverColumn, setDragOverColumn] = useState<ColumnId | null>(null);
  const [editingCard, setEditingCard] = useState<SprintCard | null>(null);
  const [editingCardColumn, setEditingCardColumn] = useState<ColumnId | null>(null);

  const handleDragStart = useCallback((e: DragEvent<HTMLDivElement>, card: SprintCard, columnId: ColumnId) => {
    setDraggedCard(card);
    setDraggedFromColumn(columnId);
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/plain', card.id);
    // Add a slight delay to allow the drag image to be set
    setTimeout(() => {
      const target = e.target as HTMLElement;
      target.style.opacity = '0.5';
    }, 0);
  }, []);

  const handleDragEnd = useCallback((e: DragEvent<HTMLDivElement>) => {
    const target = e.target as HTMLElement;
    target.style.opacity = '1';
    setDraggedCard(null);
    setDraggedFromColumn(null);
    setDragOverColumn(null);
  }, []);

  const handleDragOver = useCallback((e: DragEvent<HTMLDivElement>, columnId: ColumnId) => {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
    setDragOverColumn(columnId);
  }, []);

  const handleDragLeave = useCallback(() => {
    setDragOverColumn(null);
  }, []);

  const handleDrop = useCallback((e: DragEvent<HTMLDivElement>, targetColumnId: ColumnId) => {
    e.preventDefault();

    if (!draggedCard || !draggedFromColumn) return;

    // Don't do anything if dropping in the same column
    if (targetColumnId === draggedFromColumn) {
      setDragOverColumn(null);
      return;
    }

    setCards((prevCards) => {
      // Remove from source column
      const sourceCards = prevCards[draggedFromColumn].filter(c => c.id !== draggedCard.id);
      // Add to target column
      const targetCards = [...prevCards[targetColumnId], draggedCard];

      return {
        ...prevCards,
        [draggedFromColumn]: sourceCards,
        [targetColumnId]: targetCards,
      };
    });

    setDragOverColumn(null);
  }, [draggedCard, draggedFromColumn]);

  const moveCard = useCallback((card: SprintCard, fromColumn: ColumnId, toColumn: ColumnId) => {
    if (fromColumn === toColumn) return;

    setCards((prevCards) => {
      const sourceCards = prevCards[fromColumn].filter(c => c.id !== card.id);
      const targetCards = [...prevCards[toColumn], card];

      return {
        ...prevCards,
        [fromColumn]: sourceCards,
        [toColumn]: targetCards,
      };
    });
  }, []);

  const handleEditCard = (card: SprintCard, columnId: ColumnId) => {
    setEditingCard(card);
    setEditingCardColumn(columnId);
  };

  const handleSaveCard = (updatedCard: SprintCard) => {
    if (!editingCardColumn) return;

    setCards((prevCards) => ({
      ...prevCards,
      [editingCardColumn]: prevCards[editingCardColumn].map(c =>
        c.id === updatedCard.id ? updatedCard : c
      ),
    }));
  };

  return (
    <div className="sprint-board">
      <div className="sprint-header">
        <h1>Sprint Board</h1>
        <p>Drag cards between columns to update status</p>
      </div>
      <div className="sprint-columns">
        {columns.map((column) => (
          <div
            key={column.id}
            className={`sprint-column ${dragOverColumn === column.id ? 'drag-over' : ''}`}
            onDragOver={(e) => handleDragOver(e, column.id)}
            onDragLeave={handleDragLeave}
            onDrop={(e) => handleDrop(e, column.id)}
            style={{ '--column-color': column.color } as React.CSSProperties}
          >
            <div className="column-header" style={{ backgroundColor: column.color }}>
              <h3>{column.title}</h3>
              <span className="card-count">{cards[column.id].length}</span>
            </div>
            <div className="column-cards">
              {cards[column.id].map((card) => (
                <div
                  key={card.id}
                  className="sprint-card"
                  draggable
                  onDragStart={(e) => handleDragStart(e, card, column.id)}
                  onDragEnd={handleDragEnd}
                >
                  <h4>{card.title}</h4>
                  <p>{card.description}</p>
                  <div className="progress-bar">
                    <div
                      className="progress-fill"
                      style={{ width: `${card.progress}%` }}
                    />
                    <span className="progress-text">{card.progress}%</span>
                  </div>
                  <div className="card-actions">
                    <button
                      className="edit-btn"
                      onClick={() => handleEditCard(card, column.id)}
                    >
                      Edit
                    </button>
                    <select
                      className="move-select"
                      value=""
                      onChange={(e) => {
                        if (e.target.value) {
                          moveCard(card, column.id, e.target.value as ColumnId);
                        }
                      }}
                    >
                      <option value="">Move to...</option>
                      {columns
                        .filter((c) => c.id !== column.id)
                        .map((c) => (
                          <option key={c.id} value={c.id}>
                            {c.title}
                          </option>
                        ))}
                    </select>
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
      {editingCard && (
        <EditModal
          card={editingCard}
          onSave={handleSaveCard}
          onClose={() => {
            setEditingCard(null);
            setEditingCardColumn(null);
          }}
        />
      )}
    </div>
  );
}
